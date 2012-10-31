class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load
  autocomplete :patient, :medicaldiag, full: true
  
   def load
    @req_url=request.host_with_port
    @more_fields||= PatientUserDefinedFields.all
    @devices||= Device.all
    end
end
