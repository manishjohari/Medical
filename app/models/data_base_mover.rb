class DataBaseMover
  def self.run(database_name)
    if database_name
      ActiveRecord::Base.connection.execute("CREATE DATABASE #{database_name}")

      ActiveRecord::Base.establish_connection(
       :adapter  => "postgresql",
       :host     => "localhost",
       :username => "postgres",
       :password => "",
       :database => "#{database_name}"
      )

      ActiveRecord::Base.connection.create_table :patient_user_defined_fields do |t|
      t.string :field_name
      t.timestamps
     end
      ActiveRecord::Base.connection.create_table :patient_user_defined_data do |t|
      t.integer :patient_id
      t.string :field_name
      t.string :data

      t.timestamps
    end     
      ActiveRecord::Base.connection.create_table :audits do |t|
      t.string :record_id
      t.string :record_type
      t.datetime :date
      t.string :ip
      t.string :action

      t.timestamps
    end
      ActiveRecord::Base.connection.create_table :audit_logs do |t|
      t.integer :audit_id
      t.string :record_id
      t.string :old_data
      t.string :new_data

      t.timestamps
    end
      ActiveRecord::Base.connection.create_table :mandatory_fields do |t|
      t.string :fields
      t.boolean :is_mandatory

      t.timestamps
    end
      ActiveRecord::Base.connection.create_table :automated_db_backups do |t|
      t.string :time

      t.timestamps
    end
      ActiveRecord::Base.connection.create_table :patients do |t|
      t.string :patientid
      t.string :sex
      t.string :ssn
      t.datetime :birthdate
      t.string :namefirst
      t.string :namem
      t.string :namelast
      t.string :race
      t.string :bloodtype
      t.string :addressstreet
      t.string :addresstown
      t.string :addressstate
      t.string :addresszip
      t.string :addresscountry
      t.string :telenumber
      t.string :oculardiag
      t.string :medicaldiag
      t.datetime :firstvisitdate
      t.string :comments
      t.boolean :is_delete, :default => false
      t.integer :db, :default=>0
      t.timestamps
    end    
    ActiveRecord::Base.connection.create_table :slitlamps do |t|
      t.integer :patient_id
      t.string :patientid
      t.integer :imageid
      t.datetime :datetime
      t.string :od_os
      t.string :equipinfo
      t.string :description
      t.string :celldensity
      t.string :meancellarea
      t.string :imagebuffer
      t.string :title
      t.string :disease
      t.string :title
      t.string :disease
      t.string :cddelta
      t.string :cv
      t.string :hexagonality
      t.string :analysed
      t.string :location
      t.string :imagefilename
      t.boolean :is_delete, :default => false
      t.integer :db, :default=>0
      t.string :pimage_file_name
      t.string :pimage_content_type
      t.integer :pimage_file_size

      t.timestamps
    end                  
    ActiveRecord::Base.connection.create_table :devices do |t|
      t.string :device_name

      t.timestamps
    end
    
      envr = "development:
                      adapter: postgresql
                      encoding: unicode
                      database: #{database_name}
                      pool: 5
                      username: postgres
                      password:

                      host: localhost
                      port: 5432"
         `echo '#{envr}' >> '#{Rails.root}/config/#{database_name}.yml'`
         Rails.configuration.database_configuration_file="config/#{database_name}.yml"
         
         mfs = MandatoryFields.create([{:fields=>"comments"},{:fields=>"patientid"},{:fields=>"sex"},{:fields=>"firstvisitdate"},{:fields=>"ssn"},{:fields=>"birthdate"},{:fields=>"namefirst"},{:fields=>"namem"},{:fields=>"race"},{:fields=>"addressstreet"},{:fields=>"bloodtype"},{:fields=>"addresstown"},{:fields=>"addresszip"},{:fields=>"addresscountry"},{:fields=>"telenumber"},{:fields=>"oculardiag"},{:fields=>"medicaldiag"},{:fields=>"addressstate"}])
if !mfs.nil?
MandatoryFields.all.each do |mf|
mf.update_attributes(:is_mandatory=>"false")
end
end
          
    end  
  end
end
