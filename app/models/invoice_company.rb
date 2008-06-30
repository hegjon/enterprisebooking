class InvoiceCompany < ActiveRecord::Base
  has_many :contractors
  has_many :bookings
end
