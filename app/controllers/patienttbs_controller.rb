class PatienttbsController < ApplicationController
  # GET /patienttbs
  # GET /patienttbs.xml
  def index
   if !Patienttb.first.nil?
    #@patienttbs = Patienttb.all(:is_delete => nil  or :is_delete => false)
    @patienttbs =Patienttb.find_by_sql("select * from patienttbs where is_delete is null or is_delete='false'")
    else
    @patienttbs = Patienttb.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patienttbs }
    end
  end

  # GET /patienttbs/1
  # GET /patienttbs/1.xml
  def show
    @patienttb = Patienttb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patienttb }
    end
  end

  # GET /patienttbs/new
  # GET /patienttbs/new.xml
  def new
    @patienttb = Patienttb.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patienttb }
    end
  end

  # GET /patienttbs/1/edit
  def edit
    @patienttb = Patienttb.find(params[:id])
  end

  # POST /patienttbs
  # POST /patienttbs.xml
  def create
    @patienttb = Patienttb.new(params[:patienttb])

    respond_to do |format|
      if @patienttb.save
      Audit.create(:record_id=>@patienttb.id, :record_type=>'patienttb', :date=>Time.now, :action=>"New", :ip=>request.remote_ip) 
        format.html { redirect_to(@patienttb, :notice => 'Patienttb was successfully created.') }
        format.xml  { render :xml => @patienttb, :status => :created, :location => @patienttb }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patienttb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patienttbs/1
  # PUT /patienttbs/1.xml
  
  def update
#  render :json=>params
#  return
@old=Array.new
@new=Array.new
    @patienttb = Patienttb.find(params[:id])
    @old_patienttb=@patienttb.clone
    respond_to do |format|
      if @patienttb.update_attributes(params[:patienttb])
             @old_patienttb.attributes.each do |key, value|
                    if key!='updated_at'
                        if @patienttb[key]!=value
                        @old << key
                        @old << value
                        @new << key
                        @new << @patienttb[key]
                        end
                    end
              end
        @audit=Audit.create(:record_id=>@patienttb.id, :record_type=>'patienttb', :date=>Time.now, :action=>"Mod", :ip=>request.remote_ip) 
        @audit.create_audit_log(:record_id=>@patienttb.id, :old_data=>@old, :new_data=>@new)
        format.html { redirect_to(@patienttb, :notice => 'Patienttb was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patienttb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patienttbs/1
  # DELETE /patienttbs/1.xml
  def destroy
    @patienttb = Patienttb.find(params[:id])
    @patienttb.update_attributes(:is_delete => true)
    Audit.create(:record_id=>@patienttb.id, :record_type=>'patienttb', :date=>Time.now, :action=>"Del", :ip=>request.remote_ip) 
    respond_to do |format|
      format.html { redirect_to(patienttbs_url) }
      format.xml  { head :ok }
    end
  end
end
