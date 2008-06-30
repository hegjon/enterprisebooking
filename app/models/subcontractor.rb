class Subcontractor < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :bookings
  
  has_many :company_profiles
end
