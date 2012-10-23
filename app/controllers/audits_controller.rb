class AuditsController < ApplicationController
  def index
  @audits||=Audit.all
  render :layout => false
  end

  def audit_logs
  @audit=Audit.find(params[:id])
  @audit_log=@audit.audit_log
  render :layout => false
  end

end
