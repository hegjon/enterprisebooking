class Subcontractor < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :bookings
end
