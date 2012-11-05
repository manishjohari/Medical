class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :databases, :load
  autocomplete :patient, :medicaldiag, full: true
  
   def load
    @running_db = Load.currently_active_database 
    @req_url=request.host_with_port
    @more_fields||= PatientUserDefinedFields.all
    @devices||= Device.all
    end
    
    def databases
    Load.default_database
    @databases=Database.all
    Load.current_database
    end

end
