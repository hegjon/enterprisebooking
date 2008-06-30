class Base < ActiveRecord::Migration
  def self.up
    create_table "barracks", :force => true do |t|
      t.integer "camp_id", :limit => 11, :null => false
      t.string  "code",    :limit => 10, :null => false
      t.string  "name"
    end

    add_index "barracks", ["camp_id", "code"], :name => "index_barracks_on_camp_id_and_code", :unique => true

    create_table "bookings", :force => true do |t|
      t.integer  "profile_id", :limit => 11
      t.datetime "arrival",                 :null => false
      t.datetime "departure",               :null => false
      t.integer  "status",    :limit => 11, :null => false
    end

    add_index "bookings", ["profile_id"], :name => "index_bookings_on_profile_id"
    add_index "bookings", ["arrival", "departure"], :name => "index_bookings_on_arrival_and_departure"

    create_table "camps", :force => true do |t|
      t.string "code", :limit => 10, :null => false
      t.string "name"
    end

    add_index "camps", ["code"], :name => "index_camps_on_code", :unique => true

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

    create_table :profiles do |t|      
      t.string :code
      t.string :first_name
      t.string :last_name      
    end

    create_table :company_profiles do |t|
      t.references :profile
      t.references :invoice_company, :null => false
      t.references :contractor, :null => false
      t.references :subcontractor

      t.string :code
      t.string :first_name
      t.string :last_name            
    end

    add_index :company_profiles, ["invoice_company_id"]
    add_index :company_profiles, ["contractor_id"]
    add_index :company_profiles, ["subcontractor_id"]
    
    
    create_table :profile_categories_profiles do |t|
      t.integer "profile_id",          :limit => 11
      t.integer "profile_category_id", :limit => 11
    end

    add_index :profile_categories_profiles, ["profile_id", "profile_category_id"], :name => "index_profile_profile_categories", :unique => true

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

    create_table "reservations", :force => true do |t|
      t.integer "profile_id", :limit => 11
      t.integer "room_id",   :limit => 11
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
      t.integer "status",     :limit => 11,                :null => false
      t.integer "beds",       :limit => 11, :default => 1, :null => false
    end

    add_index "rooms", ["barrack_id", "code"], :name => "index_rooms_on_barrack_id_and_code", :unique => true

    create_table "subcontractors", :force => true do |t|
      t.string  "code",          :limit => 10, :null => false
      t.string  "name",                        :null => false
      t.integer "contractor_id", :limit => 11, :null => false
    end
  end

  def self.down

  end
end
