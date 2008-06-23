class CreateRoomCategories < ActiveRecord::Migration
  def self.up
    create_table :room_categories do |t|
      t.string :name, :null => false
      t.string :abbrivation
      t.integer :order
      t.integer :auto_on
      t.integer :auto_off
    end
    
    create_table :room_categories_rooms do |t|
      t.references :room
      t.references :room_category
    end
    
    add_index(:room_categories_rooms, [:room_id, :room_category_id], :unique => true, :name => "index_room_categories_room")
  end

  def self.down
    drop_table :room_categories_rooms
    drop_table :room_categories
  end
end
