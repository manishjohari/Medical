class Audit < ActiveRecord::Base
has_one :audit_log
end
