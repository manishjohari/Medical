class CreateDatabases < ActiveRecord::Migration
  def self.up
    create_table :databases do |t|
      t.string :database_name
      t.string :is_active, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :databases
  end
end
