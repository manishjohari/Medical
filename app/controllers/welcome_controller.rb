class WelcomeController < ApplicationController
  def index
  @more_fields=PatientUserDefinedFields.all
  end

  def tounzip
  if !params[:file_upload].nil?
            require 'fileutils'
            tmp = params[:file_upload][:my_file].tempfile
            file = File.join("public", params[:file_upload][:my_file].original_filename)
            FileUtils.cp tmp.path, file
              `rm -rf ./public/unzipped/`
            @resp=`unzip -o "#{file}" -d public/unzipped`
             FileUtils.rm file
           
                         session[:db]=Patienttb.maximum(:db)
                         if (session[:db]==nil || session[:db]==0)
                            session[:db]=1
                           session[:from_patient]=Patienttb.maximum(:id)
                           session[:from_slitlamp]=Slitlamptb.maximum(:id)
                           @image_pat =`find -name NEW -type d`
                           @image_path = @image_pat.gsub("\n","")
                           `mkdir ./public/images/old/#{session[:db]}`
                           `mv \"#{@image_path}\"/* ./public/images/old/#{session[:db]}/`
                        else
                           session[:db]=Patienttb.maximum(:db).next
                           session[:from_patient]=Patienttb.maximum(:id)
                           session[:from_slitlamp]=Slitlamptb.maximum(:id)
                           @image_pat =`find -name NEW -type d`
                           @image_path = @image_pat.gsub("\n","")
                            `mkdir ./public/images/old/#{session[:db]}`
                            `mv \"#{@image_path}\"/* ./public/images/old/#{session[:db]}/`
                           end
             @db_pat= `find . -name "*.MDB"`
             @db_path=@db_pat.gsub("\n","").to_s
             @t = `mdb-tables -1 \"#{@db_path}\"`
             @tables=@t.split(" ")
             @tables.each do |table|
             @ty=`mdb-export -I  -q "'" -R'; \n' \"#{@db_path}\" #{table}  | sed 's/#{table}/#{table}S/g'>#{table}.sql`
                `psql -U postgres Medical_pro_development < #{table}.sql`
              end
              row_inserted_patient=`mdb-array \"#{@db_path}\" PatientTB | grep -r "PatientTB_array_length" | grep -ioE [0-9]`
              row_inserted_slitlamp=`mdb-array \"#{@db_path}\" SlitlampTB | grep -r "SlitlampTB_array_length" | grep -ioE [0-9]`
              Audit.create(:record_id=>row_inserted_patient.gsub("\n","").to_s, :record_type=>'patienttbs', :date=>Time.now, :action=>".Zip Uplaod", :ip=>request.remote_ip)
              Audit.create(:record_id=>row_inserted_slitlamp.gsub("\n","").to_s, :record_type=>'slitlamptbs', :date=>Time.now, :action=>".Zip Uplaod", :ip=>request.remote_ip)
          redirect_to '/tosql'
         else
         flash[:notice] ="Select .Zip File to Upload"
         redirect_to '/index'
         end
  end
  
  def tosql
#update db value in patienttb 
     if session[:from_patient].nil?
        from_patient=0
       else
        from_patient=session[:from_patient]
     end  
        patients=Patienttb.where("id >=? ", from_patient.next.to_i)
          patients.each do |patient|
              patient.update_attributes(:db=>session[:db].to_i)
           end
##update db value in patienttb table
       
#update db value in slitlamptb
       if session[:from_slitlamp].nil?
          from_slitlamp=0
       else
          from_slitlamp=session[:from_slitlamp]
       end
       slitlamps=Slitlamptb.where("id >=?", from_slitlamp.next.to_i)
        slitlamps.each do |slitlamp|
          slitlamp.update_attributes(:db=>session[:db].to_i)
        end
##update db value in slilamptb
        
#update patienttb_id in slitlamp to make has_many relation while uploading Zip file
        Slitlamptb.where(:db=>session[:db].to_i).each do |slitlamp|
            pid=Patienttb.find(:first, :conditions => ['patientid = ? and db = ?', slitlamp.patientid, session[:db].to_i]).id
            slitlamp.update_attributes(:patienttb_id=>pid)
         end
##
          session[:from_patient]=nil
          session[:from_slitlamp]=nil
          session[:db]=nil
     flash[:notice] ="File Unzipped successfully"
          redirect_to '/index'   

  end
  
   def settings
  
  end
  
  def set_mendatory
  @patient_columns=Patienttb.column_names-["id" ,"created_at", "updated_at"]
  @mandatory=MandatoryFields.all
  end
  
  def save_settings
  MandatoryFields.all.each do |m|
      m.update_attributes(:is_mandatory=>false)
  end
      if params[:field]
           params[:field].each do |field|
          MandatoryFields.where(:fields=>field).first.update_attributes(:is_mandatory=>true)
          end
      end
    redirect_to '/index' 
  end
  
  def custom_to_patient
  @cf=PatientUserDefinedFields.all
  end
  
  def add_fields
      params[:custom].each do |custom_field|
          PatientUserDefinedFields.create(:field_name=>custom_field)
      end
      redirect_to "/custom_to_patient"
  end
  
  def custom_field_destroy
  @cf = PatientUserDefinedFields.find(params[:id])
  @cf.destroy
  flash[:notice]="Field Destroyed Successfully"
  redirect_to "/custom_to_patient"
  end
  
  def add_more_data
  render :json=>params[:custom_fields]
  return
  redirect_to "/index"
  end
  
  def login
  @user = User.find_by_email(params[:email]) if params[:email]
      if !@user.nil?
          if (@user.password== params[:password]) 
            session[:user]=@user.id
            flash[:notice]="Logged in Successfully"
            redirect_to "/index"
            return
           end
          flash[:notice]="Wrong Password"
          redirect_to "/index"
      else
        flash[:notice]="Wrong Email"
        redirect_to "/index"
      end
  end
  
  def signup
      if params[:email].blank?
          flash[:notice]="Email cannot be blank"
            redirect_to "/index"
      else
                  if ((params[:password]==params[:cpassword]) and !params[:password].empty?)
                    @user=User.new(:email=>params[:email], :password=>params[:password])
                    @user.save!
                    session[:user]=@user.id
                    flash[:notice]="Account Created Successfully"
                      redirect_to "/index"
                   else
                     flash[:notice]="Password does not Match"
                     redirect_to "/index"
                   end
       end     
  end
  
  def signout
  session[:user]=nil
   flash[:notice]="Logout Successfully"
  redirect_to '/index'
  end
  
end
