class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :person
  
  belongs_to :invoice_company
  belongs_to :contractor
  belongs_to :subcontractor
end
