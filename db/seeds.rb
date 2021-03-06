# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

mfs = MandatoryFields.create([{:fields=>"comments"},{:fields=>"patientid"},{:fields=>"sex"},{:fields=>"firstvisitdate"},{:fields=>"ssn"},{:fields=>"birthdate"},{:fields=>"namefirst"},{:fields=>"namem"},{:fields=>"race"},{:fields=>"addressstreet"},{:fields=>"bloodtype"},{:fields=>"addresstown"},{:fields=>"addresszip"},{:fields=>"addresscountry"},{:fields=>"telenumber"},{:fields=>"oculardiag"},{:fields=>"medicaldiag"},{:fields=>"addressstate"}])
if !mfs.nil?
MandatoryFields.all.each do |mf|
mf.update_attributes(:is_mandatory=>"false")
end
end
