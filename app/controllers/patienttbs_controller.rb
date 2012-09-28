class PatienttbsController < ApplicationController
  # GET /patienttbs
  # GET /patienttbs.xml
  def index
    if params[:search]
      @patienttbs=Patienttb.search(params[:search])
    else
         if !Patienttb.first.nil?
          #@patienttbs = Patienttb.all(:is_delete => nil  or :is_delete => false)
         # @patienttbs =Patienttb.find_by_sql("select * from patienttbs where is_delete is null or is_delete='false'")
         @patienttbs = Patienttb.not_deleted
          else
          @patienttbs = Patienttb.all
          end
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
    @custom_data = @patienttb.patient_user_defined_datas
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patienttb }
    end
  end

  # GET /patienttbs/new
  # GET /patienttbs/new.xml
  def new
  @h1="New Patient"
    @patienttb = Patienttb.new
     @p=PatientUserDefinedFields.all
     
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patienttb }
    end
  end

  

  # POST /patienttbs
  # POST /patienttbs.xml
  def create
    @h1="New Patient"
    @patienttb = Patienttb.new(params[:patienttb])
    @p=PatientUserDefinedFields.all

    respond_to do |format|
      if @patienttb.save
          if params[:slitlamptb]
	          @image=@patienttb.slitlamptbs.create(params[:slitlamptb])
        	end
           if params[:custom]
           params[:custom].each do|key,value| 
                @patienttb.patient_user_defined_datas.create(:field_name=>key, :data=>value)
              end
           end
          Audit.create(:record_id=>@patienttb.id, :record_type=>'patienttb', :date=>Time.now, :action=>"New", :ip=>request.remote_ip) 
            format.html { redirect_to(@patienttb, :notice => 'Patient was successfully created.') }
            format.xml  { render :xml => @patienttb, :status => :created, :location => @patienttb }
      else
            format.html { render :action => "new" }
            format.xml  { render :xml => @patienttb.errors, :status => :unprocessable_entity }
      end
    end
  end

# GET /patienttbs/1/edit
  def edit
  @h1="Editing Patient"
    @patienttb = Patienttb.find(params[:id])
     
      @p=@patienttb.patient_user_defined_datas
         old_field=Array.new
             @p.each do |p|
                  old_field << p.field_name
             end
         all_field=Array.new
             PatientUserDefinedFields.all.each do |cf|
                all_field << cf.field_name
             end
        @new_field= all_field-old_field
  end

  # PUT /patienttbs/1
  # PUT /patienttbs/1.xml
  
  def update
@h1="Editing Patient"
@old=Array.new
@new=Array.new
    @patienttb = Patienttb.find(params[:id])
    @p=@patienttb.patient_user_defined_datas
         old_field=Array.new
             @p.each do |p|
                  old_field << p.field_name
             end
         all_field=Array.new
             PatientUserDefinedFields.all.each do |cf|
                all_field << cf.field_name
             end
        @new_field= all_field-old_field
    @old_patienttb=@patienttb.clone
     
    respond_to do |format|
   
      if @patienttb.update_attributes(params[:patienttb])
        if params[:slitlamptb]
        #@patienttb.slitlamptb.update_attributes(params[:slitlamptb])
        end
            ##update custom field values
          if params[:custom]
             params[:custom].each do |key, value|
                @patient=@patienttb.patient_user_defined_datas.where(:field_name=>key).first
                    if !@patient.nil?
                       @patient.update_attributes(:data=>value)
                    else
                       @patienttb.patient_user_defined_datas.create(:field_name=>key, :data=>value)                        
                    end
                #@patient.first.update_attributes(:data=>value)
             end
          end
             ##
      
            ##update entry in audit and audit logs
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
        ##
        format.html { redirect_to(@patienttb, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
      
        format.html {render :action => "edit" }#redirect_to "/patienttbs/"+params[:id]+"/edit" }
        format.xml  { render :xml => @patienttb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patienttbs/1
  # DELETE /patienttbs/1.xml
  def destroy
    @patienttb = Patienttb.find(params[:id])
    @patienttb.update_attributes(:is_delete => true)
    @patienttb.save(:validate=>false)
    Audit.create(:record_id=>@patienttb.id, :record_type=>'patienttb', :date=>Time.now, :action=>"Del", :ip=>request.remote_ip) 
    respond_to do |format|
      format.html { redirect_to(patienttbs_url) }
      format.xml  { head :ok }
    end
  end
end
