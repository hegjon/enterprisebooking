class Contractor < ActiveRecord::Base
  belongs_to :invoice_company
  has_many :profile
  has_many :subcontractors
  has_many :bookings
end
