class Patienttb < ActiveRecord::Base

    scope :not_deleted, :conditions => ["is_delete = ?", false ]
   
    has_many :slitlamptbs
    has_many :patient_user_defined_datas
   
    validates_presence_of :namelast, :message => "Please Enter Last Name" 

        mf||=MandatoryFields.all
        if mf.find(:fields=>"comments").first.is_mandatory==true
            validates_presence_of :comments, :message => "Please Enter Comments"
        end

        if mf.find(:fields=>"patientid").first.is_mandatory==true
            validates_presence_of :patientid, :message => "Please Enter Patient ID"
        end
        if mf.find(:fields=>"sex").first.is_mandatory==true
            validates_presence_of :sex, :message => "Please Enter Sex"
        end
        if mf.find(:fields=>"firstvisitdate").first.is_mandatory==true
            validates_presence_of :firstvisitdate, :message => "Please Enter Date of Visit" 
        end
        if mf.find(:fields=>"ssn").first.is_mandatory==true
            validates_presence_of :ssn, :message => "Please Enter SSN" 
        end
        if mf.find(:fields=>"birthdate").first.is_mandatory==true
            validates_presence_of :birthdate, :message => "Please Enter Date of Birth" 
        end
        if mf.find(:fields=>"namefirst").first.is_mandatory==true
            validates_presence_of :namefirst, :message => "Please Enter First Name" 
        end
        if mf.find(:fields=>"namem").first.is_mandatory==true
            validates_presence_of :namem, :message => "Please Enter Middle Name" 
        end
        if mf.find(:fields=>"race").first.is_mandatory==true
            validates_presence_of :race,  :message => "Please Enter Race" 
        end
        if mf.find(:fields=>"addressstreet").first.is_mandatory==true
            validates_presence_of :addressstreet, :message => "Please Enter Address Street" 
        end
        if mf.find(:fields=>"bloodtype").first.is_mandatory==true
            validates_presence_of :bloodtype, :message => "Please Enter Blood Type" 
        end
        if mf.find(:fields=>"addresstown").first.is_mandatory==true
            validates_presence_of :addresstown, :message => "Please Enter Address Town" 
        end
        if mf.find(:fields=>"addresszip").first.is_mandatory==true
            validates_presence_of :addresszip, :message => "Please Enter Address Zip" 
        end
        if mf.find(:fields=>"addresscountry").first.is_mandatory==true
            validates_presence_of :addresscountry, :message => "Please Enter Address Country" 
        end
        if mf.find(:fields=>"telenumber").first.is_mandatory==true
            validates_presence_of :telenumber, :message => "Please Enter Telephone Number" 
        end
        if mf.find(:fields=>"oculardiag").first.is_mandatory==true
            validates_presence_of :oculardiag, :message => "Please Enter Ocular diagnosis" 
        end
        if mf.find(:fields=>"medicaldiag").first.is_mandatory==true
            validates_presence_of :medicaldiag, :message => "Please Enter Medical diagnosis" 
        end
        if mf.find(:fields=>"addressstate").first.is_mandatory==true
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
