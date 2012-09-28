class AuditsController < ApplicationController
  def index
  @audits=Audit.all
  end

  def audit_logs
  @audit=Audit.find(params[:id])
  @audit_log=@audit.audit_log
 # render :text=>@audit_log.old_data
 # return
  end

end
