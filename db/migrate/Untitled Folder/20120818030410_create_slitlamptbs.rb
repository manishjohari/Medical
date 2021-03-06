class CreateSlitlamptbs < ActiveRecord::Migration
  def self.up
    create_table :slitlamptbs do |t|
      t.integer :patienttb_id
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
      t.integer :db, :default=>0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :slitlamptbs
  end
end
