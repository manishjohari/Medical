class CreateMandatoryFields < ActiveRecord::Migration
  def self.up
    create_table :mandatory_fields do |t|
      t.string :fields
      t.boolean :is_mandatory

      t.timestamps
    end
  end

  def self.down
    drop_table :mandatory_fields
  end
end
