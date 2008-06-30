class Profile < ActiveRecord::Base
  has_many :bookings, :order => "arrival"
  has_and_belongs_to_many :reservations, :class_name => "Room",  :join_table => "reservations"
  has_and_belongs_to_many :profile_categories
  
  has_one :camp_profile
  has_many :company_profiles
end
