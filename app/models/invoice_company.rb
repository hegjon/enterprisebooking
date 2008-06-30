class InvoiceCompany < ActiveRecord::Base
  has_many :contractors
  has_many :bookings
  has_many :camp_profiles
end
