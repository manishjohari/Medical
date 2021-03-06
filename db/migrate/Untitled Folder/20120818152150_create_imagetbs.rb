class CreateImagetbs < ActiveRecord::Migration
  def self.up
    create_table :imagetbs do |t|
      t.string :patientid
      t.integer :imageid
      t.datetime :datetime
      t.string :od_os
      t.string :equipinfo
      t.string :description
      t.string :celldensity
      t.string :meancellarea
      t.string :imagebuffer
      t.string :title
      t.string :disease
      t.string :title
      t.string :disease
      t.string :cddelta
      t.string :cv
      t.string :hexagonality
      t.string :analysed
      t.string :location
      t.string :imagefilename

      t.timestamps
    end
  end

  def self.down
    drop_table :imagetbs
  end
end
