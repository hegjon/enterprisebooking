class BookingStatus < ActiveRecord::Migration
  def self.up
    add_column :bookings, :status, :integer, :null => false
    add_column :rooms, :status, :integer, :null => false
    add_column :rooms, :beds, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column(:rooms, :status)
    remove_column(:rooms, :beds)
    remove_column(:bookings, :status)
  end
end
