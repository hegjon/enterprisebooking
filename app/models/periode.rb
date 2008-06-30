class Periode < ActiveRecord::Base
  belongs_to :room
  belongs_to :booking
end
