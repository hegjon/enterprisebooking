class Base < ActiveRecord::Migration
  def self.up
    create_table :camps do |t|
      t.string :code, :null => false, :limit => 10
      t.string :name
    end
    
    create_table :barracks do |t|
      t.references :camp, :null => false
      t.string :code, :null => false, :limit => 10
      t.string :name
    end
    
    create_table :rooms do |t|
      t.references :barrack, :null => false
      t.string :code, :null => false, :limit => 10
    end
    
    create_table :companies do |t|
      t.string :code, :null => false, :limit => 10
      t.string:name, :null => false
    end

    create_table :people do |t|
      t.references :company, :null => false
      t.string :first_name
      t.string :last_name
    end
    
    create_table :bookings do |t|
      t.references :room
      t.references :person
      t.datetime :arrival, :null => false
      t.datetime :departure, :null => false
    end    
    
    add_index(:camps, :code, :unique => true)
    add_index(:barracks, [:camp_id, :code], :unique => true)
    add_index(:rooms, [:barrack_id, :code], :unique => true)
    add_index(:companies, [:code], :unique => true)
    add_index(:people, :company_id)
    add_index(:bookings, :person_id)
    add_index(:bookings, :room_id)
    add_index(:bookings, [:arrival, :departure])
  end

  def self.down
    drop_table :bookings
    drop_table :people
    drop_table :companies
    drop_table :rooms
    drop_table :barracks
    drop_table :camps    
  end
end
