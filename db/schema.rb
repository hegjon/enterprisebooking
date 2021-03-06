# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080722085513) do

  create_table "barracks", :force => true do |t|
    t.integer "camp_id", :limit => 11, :null => false
    t.string  "code",    :limit => 10, :null => false
    t.string  "name"
  end

  add_index "barracks", ["camp_id", "code"], :name => "index_barracks_on_camp_id_and_code", :unique => true

  create_table "bookings", :force => true do |t|
    t.integer  "profile_id", :limit => 11
    t.datetime "arrival",                  :null => false
    t.datetime "departure",                :null => false
    t.integer  "status",     :limit => 11, :null => false
  end

  add_index "bookings", ["profile_id"], :name => "index_bookings_on_profile_id"
  add_index "bookings", ["arrival", "departure"], :name => "index_bookings_on_arrival_and_departure"

  create_table "camps", :force => true do |t|
    t.string "code", :limit => 10, :null => false
    t.string "name"
  end

  add_index "camps", ["code"], :name => "index_camps_on_code", :unique => true

  create_table "company_profiles", :force => true do |t|
    t.integer "profile_id",         :limit => 11
    t.integer "invoice_company_id", :limit => 11, :null => false
    t.integer "contractor_id",      :limit => 11, :null => false
    t.integer "subcontractor_id",   :limit => 11
    t.string  "code"
    t.string  "first_name"
    t.string  "last_name"
  end

  add_index "company_profiles", ["invoice_company_id"], :name => "index_company_profiles_on_invoice_company_id"
  add_index "company_profiles", ["contractor_id"], :name => "index_company_profiles_on_contractor_id"
  add_index "company_profiles", ["subcontractor_id"], :name => "index_company_profiles_on_subcontractor_id"

  create_table "contractors", :force => true do |t|
    t.string  "code",               :limit => 10, :null => false
    t.string  "name",                             :null => false
    t.integer "invoice_company_id", :limit => 11
  end

  add_index "contractors", ["code"], :name => "index_companies_on_code", :unique => true

  create_table "invoice_companies", :force => true do |t|
    t.string "code", :limit => 10, :null => false
    t.string "name",               :null => false
  end

  create_table "periodes", :force => true do |t|
    t.datetime "from",                     :null => false
    t.datetime "to",                       :null => false
    t.integer  "room_id",    :limit => 11, :null => false
    t.integer  "booking_id", :limit => 11, :null => false
  end

  create_table "profile_categories", :force => true do |t|
    t.string  "name",                      :null => false
    t.string  "abbrivation"
    t.integer "order",       :limit => 11
    t.integer "auto_on",     :limit => 11
    t.integer "auto_off",    :limit => 11
  end

  create_table "profile_categories_profiles", :force => true do |t|
    t.integer "profile_id",          :limit => 11
    t.integer "profile_category_id", :limit => 11
  end

  add_index "profile_categories_profiles", ["profile_id", "profile_category_id"], :name => "index_profile_profile_categories", :unique => true

  create_table "profiles", :force => true do |t|
    t.string "code"
    t.string "first_name"
    t.string "last_name"
  end

  create_table "reservations", :force => true do |t|
    t.integer "profile_id", :limit => 11
    t.integer "room_id",    :limit => 11
  end

  add_index "reservations", ["profile_id", "room_id"], :name => "index_reservations_on_profile_id_and_room_id", :unique => true

  create_table "room_categories", :force => true do |t|
    t.string  "name",                      :null => false
    t.string  "abbrivation"
    t.integer "order",       :limit => 11
    t.integer "auto_on",     :limit => 11
    t.integer "auto_off",    :limit => 11
  end

  create_table "room_categories_rooms", :force => true do |t|
    t.integer "room_id",          :limit => 11
    t.integer "room_category_id", :limit => 11
  end

  add_index "room_categories_rooms", ["room_id", "room_category_id"], :name => "index_room_categories_room", :unique => true

  create_table "rooms", :force => true do |t|
    t.integer "barrack_id", :limit => 11,                :null => false
    t.string  "code",       :limit => 10,                :null => false
    t.integer "status",     :limit => 11, :default => 1, :null => false
    t.integer "beds",       :limit => 11, :default => 1, :null => false
  end

  add_index "rooms", ["barrack_id", "code"], :name => "index_rooms_on_barrack_id_and_code", :unique => true

  create_table "subcontractors", :force => true do |t|
    t.string  "code",          :limit => 10, :null => false
    t.string  "name",                        :null => false
    t.integer "contractor_id", :limit => 11, :null => false
  end

  create_table "users", :force => true do |t|
    t.string "username",               :null => false
    t.string "password", :limit => 40, :null => false
    t.string "type",                   :null => false
  end

end
