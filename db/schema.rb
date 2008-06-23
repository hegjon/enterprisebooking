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

ActiveRecord::Schema.define(:version => 20080623103938) do

  create_table "barracks", :force => true do |t|
    t.integer "camp_id", :limit => 11, :null => false
    t.string  "code",    :limit => 10, :null => false
    t.string  "name"
  end

  add_index "barracks", ["camp_id", "code"], :name => "index_barracks_on_camp_id_and_code", :unique => true

  create_table "bookings", :force => true do |t|
    t.integer  "room_id",   :limit => 11
    t.integer  "person_id", :limit => 11
    t.datetime "arrival",                 :null => false
    t.datetime "departure",               :null => false
    t.integer  "status",    :limit => 11, :null => false
  end

  add_index "bookings", ["person_id"], :name => "index_bookings_on_person_id"
  add_index "bookings", ["room_id"], :name => "index_bookings_on_room_id"
  add_index "bookings", ["arrival", "departure"], :name => "index_bookings_on_arrival_and_departure"

  create_table "camps", :force => true do |t|
    t.string "code", :limit => 10, :null => false
    t.string "name"
  end

  add_index "camps", ["code"], :name => "index_camps_on_code", :unique => true

  create_table "companies", :force => true do |t|
    t.string "code", :limit => 10, :null => false
    t.string "name",               :null => false
  end

  add_index "companies", ["code"], :name => "index_companies_on_code", :unique => true

  create_table "people", :force => true do |t|
    t.integer "company_id", :limit => 11, :null => false
    t.string  "first_name"
    t.string  "last_name"
  end

  add_index "people", ["company_id"], :name => "index_people_on_company_id"

  create_table "people_person_categories", :force => true do |t|
    t.integer "person_id",          :limit => 11
    t.integer "person_category_id", :limit => 11
  end

  add_index "people_person_categories", ["person_id", "person_category_id"], :name => "index_people_person_categories", :unique => true

  create_table "person_categories", :force => true do |t|
    t.string  "name",                      :null => false
    t.string  "abbrivation"
    t.integer "order",       :limit => 11
    t.integer "auto_on",     :limit => 11
    t.integer "auto_off",    :limit => 11
  end

  create_table "reservations", :force => true do |t|
    t.integer "person_id", :limit => 11
    t.integer "room_id",   :limit => 11
  end

  add_index "reservations", ["person_id", "room_id"], :name => "index_reservations_on_person_id_and_room_id", :unique => true

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
    t.integer "status",     :limit => 11,                :null => false
    t.integer "beds",       :limit => 11, :default => 1, :null => false
  end

  add_index "rooms", ["barrack_id", "code"], :name => "index_rooms_on_barrack_id_and_code", :unique => true

end
