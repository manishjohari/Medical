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
      Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamptbs', :date=>Time.now, :action=>"New", :ip=>request.remote_ip) 
        format.html { redirect_to(@slitlamptb, :notice => 'Slitlamptb was successfully created.') }
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
      Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamptbs', :date=>Time.now, :action=>"Mod", :ip=>request.remote_ip) 
        format.html { redirect_to(@slitlamptb, :notice => 'Slitlamptb was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @slitlamptb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /slitlamptbs/1
  # DELETE /slitlamptbs/1.xml
  def destroy
    @slitlamptb = Slitlamptb.find(params[:id])
    #@slitlamptb.destroy
    @slitlamptb.update_attributes(:is_delete => true)
    Audit.create(:record_id=>@slitlamptb.id, :record_type=>'slitlamptbs', :date=>Time.now, :action=>"Del", :ip=>request.remote_ip) 

    respond_to do |format|
      format.html { redirect_to(slitlamptbs_url) }
      format.xml  { head :ok }
    end
  end
end
