class Person < ActiveRecord::Base
  belongs_to :company
  has_many :bookings, :order => "arrival"
  has_and_belongs_to_many :reservations, :class_name => "Room",  :join_table => "reservations"
end
