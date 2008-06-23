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
  end

  def self.down
    drop_table :room_categories
  end
end
