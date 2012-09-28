class Patienttb < ActiveRecord::Base

    scope :not_deleted, :conditions => ["is_delete = ?", false ]
   
    has_many :slitlamptbs
    has_many :patient_user_defined_datas
   
    #validates_presence_of :namelast, :message => "Please Enter Last Name" 


        if MandatoryFields.where(:fields=>"comments").first.is_mandatory==true
            validates_presence_of :comments, :message => "Please Enter Comments"
        end

        if MandatoryFields.where(:fields=>"patientid").first.is_mandatory==true
            validates_presence_of :patientid, :message => "Please Enter Patient ID"
        end
        if MandatoryFields.where(:fields=>"sex").first.is_mandatory==true
            validates_presence_of :sex, :message => "Please Enter Sex"
        end
        if MandatoryFields.where(:fields=>"firstvisitdate").first.is_mandatory==true
            validates_presence_of :firstvisitdate, :message => "Please Enter Date of Visit" 
        end
        if MandatoryFields.where(:fields=>"ssn").first.is_mandatory==true
            validates_presence_of :ssn, :message => "Please Enter SSN" 
        end
        if MandatoryFields.where(:fields=>"birthdate").first.is_mandatory==true
            validates_presence_of :birthdate, :message => "Please Enter Date of Birth" 
        end
        if MandatoryFields.where(:fields=>"namefirst").first.is_mandatory==true
            validates_presence_of :namefirst, :message => "Please Enter First Name" 
        end
        if MandatoryFields.where(:fields=>"namem").first.is_mandatory==true
            validates_presence_of :namem, :message => "Please Enter Middle Name" 
        end
        if MandatoryFields.where(:fields=>"race").first.is_mandatory==true
            validates_presence_of :race,  :message => "Please Enter Race" 
        end
        if MandatoryFields.where(:fields=>"addressstreet").first.is_mandatory==true
            validates_presence_of :addressstreet, :message => "Please Enter Address Street" 
        end
        if MandatoryFields.where(:fields=>"bloodtype").first.is_mandatory==true
            validates_presence_of :bloodtype, :message => "Please Enter Blood Type" 
        end
        if MandatoryFields.where(:fields=>"addresstown").first.is_mandatory==true
            validates_presence_of :addresstown, :message => "Please Enter Address Town" 
        end
        if MandatoryFields.where(:fields=>"addresszip").first.is_mandatory==true
            validates_presence_of :addresszip, :message => "Please Enter Address Zip" 
        end
        if MandatoryFields.where(:fields=>"addresscountry").first.is_mandatory==true
            validates_presence_of :addresscountry, :message => "Please Enter Address Country" 
        end
        if MandatoryFields.where(:fields=>"telenumber").first.is_mandatory==true
            validates_presence_of :telenumber, :message => "Please Enter Telephone Number" 
        end
        if MandatoryFields.where(:fields=>"oculardiag").first.is_mandatory==true
            validates_presence_of :oculardiag, :message => "Please Enter Ocular diagnosis" 
        end
        if MandatoryFields.where(:fields=>"medicaldiag").first.is_mandatory==true
            validates_presence_of :medicaldiag, :message => "Please Enter Medical diagnosis" 
        end
        if MandatoryFields.where(:fields=>"addressstate").first.is_mandatory==true
            validates_presence_of :addressstate, :message => "Please Enter Address State" 
        end
        
        def self.search(search)
              if search
              find(:all, :conditions=>['namelast ILIKE ? or namefirst ILIKE ?', "%#{search}%" , "%#{search}%"])
              else
              find(:all)
              end
        end

end
