class Patienttb < ActiveRecord::Base
has_many :slitlamptb
 validates_presence_of :namelast 


        if MandatoryFields.where(:fields=>"comments").first.is_mandatory==true
            validates_presence_of :comments
        end

        if MandatoryFields.where(:fields=>"patientid").first.is_mandatory==true
            validates_presence_of :patientid 
        end
        if MandatoryFields.where(:fields=>"sex").first.is_mandatory==true
            validates_presence_of :sex
        end
        if MandatoryFields.where(:fields=>"firstvisitdate").first.is_mandatory==true
            validates_presence_of :firstvisitdate 
        end
        if MandatoryFields.where(:fields=>"ssn").first.is_mandatory==true
            validates_presence_of :ssn 
        end
        if MandatoryFields.where(:fields=>"birthdate").first.is_mandatory==true
            validates_presence_of :birthdate 
        end
        if MandatoryFields.where(:fields=>"namefirst").first.is_mandatory==true
            validates_presence_of :namefirst 
        end
        if MandatoryFields.where(:fields=>"namem").first.is_mandatory==true
            validates_presence_of :namem 
        end
        if MandatoryFields.where(:fields=>"race").first.is_mandatory==true
            validates_presence_of :race 
        end
        if MandatoryFields.where(:fields=>"addressstreet").first.is_mandatory==true
            validates_presence_of :addressstreet 
        end
        if MandatoryFields.where(:fields=>"bloodtype").first.is_mandatory==true
            validates_presence_of :bloodtype 
        end
        if MandatoryFields.where(:fields=>"addresstown").first.is_mandatory==true
            validates_presence_of :addresstown 
        end
        if MandatoryFields.where(:fields=>"addresszip").first.is_mandatory==true
            validates_presence_of :addresszip 
        end
        if MandatoryFields.where(:fields=>"addresscountry").first.is_mandatory==true
            validates_presence_of :addresscountry 
        end
        if MandatoryFields.where(:fields=>"telenumber").first.is_mandatory==true
            validates_presence_of :telenumber 
        end
        if MandatoryFields.where(:fields=>"oculardiag").first.is_mandatory==true
            validates_presence_of :oculardiag 
        end
        if MandatoryFields.where(:fields=>"medicaldiag").first.is_mandatory==true
            validates_presence_of :medicaldiag 
        end
        if MandatoryFields.where(:fields=>"addressstate").first.is_mandatory==true
            validates_presence_of :addressstate 
        end

end
