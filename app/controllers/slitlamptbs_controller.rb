class SlitlamptbsController < ApplicationController
  
  def index
   # if !Slitlamptb.first.nil?
   # @slitlamptbs = Slitlamptb.where(:is_delete => false)
    #else
    @slitlamptbs = Slitlamp.all
    #end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @slitlamptbs }
    end
  end


  def show
    @slitlamptb = Slitlamp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @slitlamptb }
    end
  end


  def new
    @slitlamptb = Slitlamp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @slitlamptb }
    end
  end

  def edit
    @slitlamptb = Slitlamp.find(params[:id])
  end

  def create
    @slitlamptb = Slitlamp.new(params[:slitlamptb])

    respond_to do |format|
      if @slitlamptb.save
      Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamps', :date=>Time.now, :action=>"New", :ip=>request.remote_ip) 
        format.html { redirect_to(@slitlamptb, :notice => 'Slitlamp was successfully created.') }
        format.xml  { render :xml => @slitlamptb, :status => :created, :location => @slitlamptb }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @slitlamptb.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @slitlamptb = Slitlamp.find(params[:id])

    respond_to do |format|
      if @slitlamptb.update_attributes(params[:slitlamptb])
      Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamp', :date=>Time.now, :action=>"Mod", :ip=>request.remote_ip) 
        format.html { redirect_to(@slitlamptb, :notice => 'Slitlamp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @slitlamptb.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_label
      @slitlamptb = Slitlamp.find(params[:id])
      @slitlamptb.update_attributes(:description=>params[:text_value])
      render :json=> @slitlamptb.description, :layout=> false
      return
  end

  def destroy
    @slitlamptb = Slitlamp.find(params[:id])
    @slitlamptb.destroy
   # @slitlamptb.update_attributes(:is_delete => true)
    Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamp', :date=>Time.now, :action=>"Del", :ip=>request.remote_ip) 

    respond_to do |format|
    format.html { redirect_to("/index") }
      #format.html { redirect_to(slitlamptbs_url) }
      format.xml  { head :ok }
    end
  end
  
  def media_upload
       if !params[:slitlamptb].nil?
            if params[:patient]
             @patient=Patient.find(params[:patient])
                 params[:slitlamptb].each do |slitlamp|
                 @slitlamp = @patient.slitlamps.create(slitlamp)
                 @slitlamp.update_attributes(:equipinfo=>params[:equipinfo])
                 end
             redirect_to "/patients/"+params[:patient]+"/device/"+params[:equipinfo]
             else
              @slitlamp = Slitlamp.create(params[:slitlamptb])
                  @slitlamp.each do |slitlamp|
                        slitlamp.update_attributes(:equipinfo=>params[:equipinfo])
                  end
              redirect_to "/index"
             end
      else
          flash[:error]="Please Select images to export"
          redirect_to "/index"
      end
  end
  
  def media_export
      if !params[:image].nil?
        if params[:image].count > 1
          FileUtils.rm_rf( Rails.root.to_s+"/public/media")
          FileUtils.mkdir( Rails.root.to_s+"/public/media")
          req_dir= File.expand_path( Rails.root.to_s+'/public/media', __FILE__)
          params[:image].each do |key, value|
            img_path=Slitlamp.find(key).pimage
            file_path=File.expand_path( Rails.root.to_s+"/public"+img_path.to_s, __FILE__)
            FileUtils.cp(file_path, req_dir)
           end
          Zipper.zip(req_dir, req_dir+'/Media.zip')
          zip_file=File.expand_path(req_dir+'/Media.zip', __FILE__)
          send_file(zip_file, :type => "application/zip", :disposition => "attachment")
          FileUtils.rm_rf(req_dir)
        else
          img_path=Slitlamp.find(params[:image].first.first).pimage.to_s
          content_type=Slitlamp.find(params[:image].first.first).pimage_content_type
          file_path=File.expand_path( Rails.root.to_s+"/public"+img_path.to_s, __FILE__)
          send_file(file_path, :type => content_type, :disposition => "attachment")
        end
      else
      flash[:error]="Please Select images to export"
      redirect_to "/index"
      end
  end
  
  def media_field_edit
        @slitlamp=Slitlamp.find(params[:id])
        if params[:type] == 'title'
        resp=@slitlamp.update_attributes(:title=>params[:tdd])
        end
        if params[:type] == 'disease'
        resp=@slitlamp.update_attributes(:disease=>params[:tdd])
        end
        if params[:type] == 'description'
        resp=@slitlamp.update_attributes(:description=>params[:tdd])
        end

        render :text =>resp
        return
  end
  
  def media_play
  @slitlamp=Slitlamp.find(params[:id])
      render :layout=>false
  end
   
end
