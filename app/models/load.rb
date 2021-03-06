class Load
 
 def self.current_database
   if !Database.where(:is_active=>true).empty?
    db_name=Database.where(:is_active=>true).first.database_name
    Rails.configuration.database_configuration_file="#{Rails.root}/config/#{db_name}.yml"
   else
    db_name="Medical_pro_development"
    Rails.configuration.database_configuration_file="#{Rails.root}/config/database.yml"
   end
    ActiveRecord::Base.establish_connection(
         :adapter  => "postgresql",
         :host     => "localhost",
         :username => "postgres",
         :password => "",
         :database => "#{db_name}"
        )
    
 end
 
 def self.default_database
  ActiveRecord::Base.establish_connection(
       :adapter  => "postgresql",
       :host     => "localhost",
       :username => "postgres",
       :password => "",
       :database => "Medical_pro_development"
      )
  #YAML::load(ERB.new(IO.read("#{Rails.root}/config/database.yml")).result)[ActiveRecord::Base.configurations["development"]]
  Rails.configuration.database_configuration_file="#{Rails.root}/config/database.yml"
 end
 
 def self.currently_active_database
  ActiveRecord::Base.connection.current_database
 end
 
 def self.custom_db(db)
 db_name=db
    Rails.configuration.database_configuration_file="#{Rails.root}/config/#{db_name}.yml"
    ActiveRecord::Base.establish_connection(
         :adapter  => "postgresql",
         :host     => "localhost",
         :username => "postgres",
         :password => "",
         :database => "#{db_name}"
        )
 
 end
 
end
