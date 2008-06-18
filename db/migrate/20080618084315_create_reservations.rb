class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.references :person
      t.references :room
    end
    
    add_index(:reservatios, [:person, :room], :unique => true)
  end

  def self.down
    drop_table :reservations
  end
end
