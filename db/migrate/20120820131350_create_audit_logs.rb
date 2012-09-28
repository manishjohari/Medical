class CreateAuditLogs < ActiveRecord::Migration
  def self.up
    create_table :audit_logs do |t|
      t.integer :audit_id
      t.string :record_id
      t.string :old_data
      t.string :new_data

      t.timestamps
    end
  end

  def self.down
    drop_table :audit_logs
  end
end
