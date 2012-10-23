class SlitlamptbsController < ApplicationController
  # GET /slitlamptbs
  # GET /slitlamptbs.xml
  
  def index
   # if !Slitlamptb.first.nil?
   # @slitlamptbs = Slitlamptb.where(:is_delete => false)
    #else
    @slitlamptbs = Slitlamptb.all
    #end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @slitlamptbs }
    end
  end

  # GET /slitlamptbs/1
  # GET /slitlamptbs/1.xml
  def show
    @slitlamptb = Slitlamptb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @slitlamptb }
    end
  end

  # GET /slitlamptbs/new
  # GET /slitlamptbs/new.xml
  def new
    @slitlamptb = Slitlamptb.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @slitlamptb }
    end
  end

  # GET /slitlamptbs/1/edit
  def edit
    @slitlamptb = Slitlamptb.find(params[:id])
  end

  # POST /slitlamptbs
  # POST /slitlamptbs.xml
  def create
    @slitlamptb = Slitlamptb.new(params[:slitlamptb])

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

  # PUT /slitlamptbs/1
  # PUT /slitlamptbs/1.xml
  def update
    @slitlamptb = Slitlamptb.find(params[:id])

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
      @slitlamptb = Slitlamptb.find(params[:id])
      @slitlamptb.update_attributes(:description=>params[:text_value])
      render :json=> @slitlamptb.description, :layout=> false
      return
  end

  # DELETE /slitlamptbs/1
  # DELETE /slitlamptbs/1.xml
  def destroy
    @slitlamptb = Slitlamptb.find(params[:id])
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
             @patient=Patienttb.find(params[:patient])
                 params[:slitlamptb].each do |slitlamp|
                  @patient.slitlamptbs.create(slitlamp)
                 end
             redirect_to "/patienttbs/"+params[:patient]+"/"
             else
              Slitlamptb.create(params[:slitlamptb])
              redirect_to "/index"
             end
      else
          flash[:error]="Please Select images to export"
          redirect_to "/index"
      end
  end
  
  def media_export
      if !params[:image].nil?
      FileUtils.rm_rf(RAILS_ROOT+"/public/media")
      FileUtils.mkdir(RAILS_ROOT+"/public/media")
      req_dir= File.expand_path(RAILS_ROOT+'/public/media', __FILE__)
      params[:image].each do |key, value|
        img_path=Slitlamptb.find(key).pimage
        file_path=File.expand_path(RAILS_ROOT+"/public"+img_path.to_s, __FILE__)
        FileUtils.cp(file_path, req_dir)
       end
      Zipper.zip(req_dir, req_dir+'/Media.zip')
      zip_file=File.expand_path(req_dir+'/Media.zip', __FILE__)
      send_file(zip_file, :type => "application/zip", :disposition => "inline")
      FileUtils.rm_rf(req_dir)
      else
      flash[:error]="Please Select images to export"
      redirect_to "/index"
      end
  end
  
  def media_field_edit
    #  str=params[:tdd]+"::"+params[:id] +"::"+params[:type]
    #  render :text => str.concat("   success")
    #  return
        @slitlamp=Slitlamptb.find(params[:id])
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
  @slitlamp=Slitlamptb.find(params[:id])
      render :layout=>false
  end
  
end
