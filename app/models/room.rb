class Room < ActiveRecord::Base
  belongs_to :barrack
  has_many :bookings
end
