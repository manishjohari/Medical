class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.string :record_id
      t.string :record_type
      t.datetime :date
      t.string :ip
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :audits
  end
end
