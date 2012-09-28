class CreatePatientUserDefinedData < ActiveRecord::Migration
  def self.up
    create_table :patient_user_defined_data do |t|
      t.integer :patienttb_id
      t.string :field_name
      t.string :data

      t.timestamps
    end
  end

  def self.down
    drop_table :patient_user_defined_data
  end
end
