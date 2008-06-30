class Reservation < ActiveRecord::Base
  belongs_to :profile
  belongs_to :room
end
