class CreateAutomatedDbBackups < ActiveRecord::Migration
  def self.up
    create_table :automated_db_backups do |t|
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :automated_db_backups
  end
end
