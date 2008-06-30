class CreatePeriodes < ActiveRecord::Migration
  def self.up
    create_table :periodes do |t|
      t.datetime :from, :null => false
      t.datetime :to, :null => false
      
      t.references :room
      t.references :booking
    end
    
   # remove_column(:bookings, :room)
  end

  def self.down
    drop_table :periodes
  end
end
