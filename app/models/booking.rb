class Booking < ActiveRecord::Base
  has_many :periodes
  has_many :rooms, :through => :periodes
  belongs_to :person
  
  belongs_to :invoice_company
  belongs_to :contractor
  belongs_to :subcontractor
end
