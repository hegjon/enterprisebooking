class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.references :person
      t.references :room
    end
    
    add_index(:reservations, [:person_id, :room_id], :unique => true)
  end

  def self.down
    drop_table :reservations
  end
end
