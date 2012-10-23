# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121023132842) do

  create_table "audit_logs", :force => true do |t|
    t.integer  "audit_id"
    t.string   "record_id"
    t.string   "old_data"
    t.string   "new_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", :force => true do |t|
    t.string   "record_id"
    t.string   "record_type"
    t.datetime "date"
    t.string   "ip"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automated_db_backups", :force => true do |t|
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.string   "device_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_upolads", :force => true do |t|
    t.string   "db_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "patientid"
    t.integer  "imageid"
    t.datetime "datetime"
    t.string   "od_os"
    t.string   "equipinfo"
    t.string   "description"
    t.string   "celldensity"
    t.string   "meancellarea"
    t.string   "imagebuffer"
    t.string   "title"
    t.string   "disease"
    t.string   "cddelta"
    t.string   "cv"
    t.string   "hexagonality"
    t.string   "analysed"
    t.string   "location"
    t.string   "imagefilename"
    t.boolean  "is_delete",     :default => false
    t.integer  "db",            :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imagetbs", :force => true do |t|
    t.string   "patientid"
    t.integer  "imageid"
    t.datetime "datetime"
    t.string   "od_os"
    t.string   "equipinfo"
    t.string   "description"
    t.string   "celldensity"
    t.string   "meancellarea"
    t.string   "imagebuffer"
    t.string   "title"
    t.string   "disease"
    t.string   "cddelta"
    t.string   "cv"
    t.string   "hexagonality"
    t.string   "analysed"
    t.string   "location"
    t.string   "imagefilename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mandatory_fields", :force => true do |t|
    t.string   "fields"
    t.boolean  "is_mandatory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_user_defined_data", :force => true do |t|
    t.integer  "patienttb_id"
    t.string   "field_name"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_user_defined_fields", :force => true do |t|
    t.string   "field_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "patientid"
    t.string   "sex"
    t.string   "ssn"
    t.datetime "birthdate"
    t.string   "namefirst"
    t.string   "namem"
    t.string   "namelast"
    t.string   "race"
    t.string   "bloodtype"
    t.string   "addressstreet"
    t.string   "addresstown"
    t.string   "addressstate"
    t.string   "addresszip"
    t.string   "addresscountry"
    t.string   "telenumber"
    t.string   "oculardiag"
    t.string   "medicaldiag"
    t.datetime "firstvisitdate"
    t.string   "comments"
    t.boolean  "is_delete",      :default => false
    t.integer  "db",             :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patienttbs", :force => true do |t|
    t.string   "patientid"
    t.string   "sex"
    t.string   "ssn"
    t.datetime "birthdate"
    t.string   "namefirst"
    t.string   "namem"
    t.string   "namelast"
    t.string   "race"
    t.string   "bloodtype"
    t.string   "addressstreet"
    t.string   "addresstown"
    t.string   "addressstate"
    t.string   "addresszip"
    t.string   "addresscountry"
    t.string   "telenumber"
    t.string   "oculardiag"
    t.string   "medicaldiag"
    t.datetime "firstvisitdate"
    t.string   "comments"
    t.boolean  "is_delete",      :default => false
    t.integer  "db",             :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slitlamps", :force => true do |t|
    t.integer  "patient_id"
    t.string   "patientid"
    t.integer  "imageid"
    t.datetime "datetime"
    t.string   "od_os"
    t.string   "equipinfo"
    t.string   "description"
    t.string   "celldensity"
    t.string   "meancellarea"
    t.string   "imagebuffer"
    t.string   "title"
    t.string   "disease"
    t.string   "cddelta"
    t.string   "cv"
    t.string   "hexagonality"
    t.string   "analysed"
    t.string   "location"
    t.string   "imagefilename"
    t.boolean  "is_delete",           :default => false
    t.integer  "db",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pimage_file_name"
    t.string   "pimage_content_type"
    t.integer  "pimage_file_size"
  end

  create_table "slitlamptbs", :force => true do |t|
    t.integer  "patienttb_id"
    t.string   "patientid"
    t.integer  "imageid"
    t.datetime "datetime"
    t.string   "od_os"
    t.string   "equipinfo"
    t.string   "description"
    t.string   "celldensity"
    t.string   "meancellarea"
    t.string   "imagebuffer"
    t.string   "title"
    t.string   "disease"
    t.string   "cddelta"
    t.string   "cv"
    t.string   "hexagonality"
    t.string   "analysed"
    t.string   "location"
    t.string   "imagefilename"
    t.integer  "db",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pimage_file_name"
    t.string   "pimage_content_type"
    t.integer  "pimage_image_size"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "type"
    t.string   "auth_type",  :default => "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
