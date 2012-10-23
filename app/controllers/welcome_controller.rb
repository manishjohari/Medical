class WelcomeController < ApplicationController
  def index
  end

  def db_upload
  render :layout => false
  end
  
  def tounzip

  if !params[:file_upload].nil?
            require 'fileutils'
            if !params[:file_upload][:my_file].content_type.match("zip")
            tmp = params[:file_upload][:my_file].tempfile
            FileUtils.rm_rf('public/restore')
            FileUtils.mkdir('public/restore')
            file = File.join("public/restore", params[:file_upload][:my_file].original_filename)
            FileUtils.cp tmp.path, file
                `rake restore`
          
            FileUtils.rm_rf('public/restore')
             flash[:notice] ="Backup done successfully"
             redirect_to '/index'
             return
            else
            name =  params[:file_upload][:my_file].original_filename
            directory = "public/data"
            path = File.join(directory, name)
            File.open(path, "wb") { |f| f.write(params[:file_upload][:my_file].read) }
            #tmp = params[:file_upload][:my_file].tempfile
            #file = File.join("public", params[:file_upload][:my_file].original_filename)
            #FileUtils.cp tmp.path, file
              `rm -rf ./public/unzipped/`
            # @resp=`unzip -o "#{file}" -d public/unzipped`
            @resp=`unzip -o "#{path}" -d public/unzipped`
                   FileUtils.rm path

              ##set db value
              session[:db]=Patienttb.maximum(:db)
               if (session[:db]==nil || session[:db]==0)
               session[:db]=1
               else
               session[:db]=Patienttb.maximum(:db).next
               end
              ##set sb value ends
              
              ##set max value of patient and slitlamp
               session[:from_patient]=Patienttb.maximum(:id)
               session[:from_slitlamp]=Slitlamptb.maximum(:id)              
              ##set max value of patient and slitlamp
             
             ##for mdb to postgressql
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
              ##for mdb to postgressql ends
              end
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
              @res=patient.save(:validate=>false)
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
          slitlamp.save(:validate=>false)
        end
  ##update db value in slilamptb
  #update patienttb_id in slitlamp to make has_many relation while uploading Zip file
        Slitlamptb.where(:db=>session[:db].to_i).each do |slitlamp|
            @patient=Patienttb.find(:first, :conditions => ['patientid = ? and db = ?', slitlamp.patientid, session[:db].to_i])
                  if @patient
                  slitlamp.update_attributes(:patienttb_id=>@patient.id)
                  end
         end
  ##update patienttb_id in slitlamp to make has_many relation while uploading Zip file ends
  
   @image_pat =`find -name NEW -type d`
   @image_path = @image_pat.gsub("\n","")
   @db=Slitlamptb.maximum(:db)
   @slitlamps=Slitlamptb.where(:db=>@db)
   @slitlamps.each do |slitlamp|
    if (!slitlamp.patientid.nil? and !slitlamp.imageid.nil?)
          @tmp_file= @image_path+'/'+slitlamp.patientid+'/Slitlamp-'+slitlamp.patientid+"-"+slitlamp.imageid.to_s+'.jpg'
          if File.exists?(@tmp_file)
          slitlamp.pimage=File.open(@tmp_file)
          @res=slitlamp.save!
          end
       end
     end
      if @res==true
          `rm -rf ./public/unzipped/`
      end

  
          session[:from_patient]=nil
          session[:from_slitlamp]=nil
          session[:db]=nil
          flash[:notice] ="File Unzipped successfully"
          redirect_to '/index'  
      
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
  
  def automate_backup
   @time=AutomatedDbBackup.first.time
  end
  
  def set_automate_backup
  @automated_backup=AutomatedDbBackup.first.update_attributes(params[:automate])
  `rm -f '#{Rails.root}/config/schedule.rb'` 
   envr = 'set :environment,"development"'
   log  = 'set :output, "log/cron_log.log"'
   `echo '#{log}' >> '#{Rails.root}/config/schedule.rb'`
   `echo '#{envr}' >> '#{Rails.root}/config/schedule.rb'`
    time=AutomatedDbBackup.first.time
    txt = time+" "+'do
         rake "backup"
       end'
    `echo '#{txt}' >> '#{Rails.root}/config/schedule.rb'`
    `whenever -i`
    
=begin  
  `rm -f '#{Rails.root}/config/schedule.rb' '#{Rails.root}/lib/tasks/shopreport.rake'`
   envr = 'set :environment,"development"'
   `echo '#{envr}' >> '#{Rails.root}/config/schedule.rb'`
   auto_mail = Automail.all
   if auto_mail
     i=0
     auto_mail.each do |a|
       txt = a.cron_time+" "+'do
         rake "shopreport'+i.to_s+'"
       end'
       task='task :shopreport'+i.to_s+' => :environment do
         obj = Admin::AutoEmailsController.new
         obj.'+a.report+'
       end'
       `echo '#{txt}' >> '#{Rails.root}/config/schedule.rb'`
       `echo '#{task}' >> '#{Rails.root}/lib/tasks/shopreport.rake'`
       i=i+1
     end
     `whenever -i`
   end
=end  
  
  redirect_to "/automate_backup"
  end

 
  
  def export_db
      dir_path=File.expand_path(RAILS_ROOT+'/public/DB_Backup',__FILE__)
       FileUtils.rm_rf(dir_path)
      `backup perform -t DB_Backup`
      file_pat=`find #{RAILS_ROOT}/public/DB_Backup  -name  *.tar`
      file_path=file_pat.gsub("\n","")
      if File.exists?(file_path)
          send_file(file_path, :type => "application/x-tar", :disposition => "attachment")
             FileUtils.rm_rf(dir_path)
      end
  end  

  
end
