class CreatePatienttbs < ActiveRecord::Migration
  def self.up
    create_table :patienttbs do |t|
      t.string :patientid
      t.string :sex
      t.string :ssn
      t.datetime :birthdate
      t.string :namefirst
      t.string :namem
      t.string :namelast
      t.string :race
      t.string :bloodtype
      t.string :addressstreet
      t.string :addresstown
      t.string :addressstate
      t.string :addresszip
      t.string :addresscountry
      t.string :telenumber
      t.string :oculardiag
      t.string :medicaldiag
      t.datetime :firstvisitdate
      t.string :comments
      t.boolean :is_delete, :default => false
      t.integer :db, :default=>0

      t.timestamps
    end
  end

  def self.down
    drop_table :patienttbs
  end
end
