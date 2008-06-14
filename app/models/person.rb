class Person < ActiveRecord::Base
  belongs_to :company
  has_many :bookings, :order => "arrival"
end
