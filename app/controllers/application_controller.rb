class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load
   def load
    @more_fields=PatientUserDefinedFields.all
    end
end
