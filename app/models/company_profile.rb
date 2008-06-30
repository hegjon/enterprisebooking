class CompanyProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :invoice_company
  belongs_to :contractor
  belongs_to :subcontractor  
end
