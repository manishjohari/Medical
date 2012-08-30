class CreatePatientUserDefinedFields < ActiveRecord::Migration
  def self.up
    create_table :patient_user_defined_fields do |t|
      t.string :field_name

      t.timestamps
    end
  end

  def self.down
    drop_table :patient_user_defined_fields
  end
end
