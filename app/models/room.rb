class Room < ActiveRecord::Base
  belongs_to :barrack
  has_many :periodes
  has_many :bookings, :through => :periodes
  has_and_belongs_to_many :reservations, :class_name => "Profile",  :join_table => "reservations"
  has_and_belongs_to_many :room_categories
end
