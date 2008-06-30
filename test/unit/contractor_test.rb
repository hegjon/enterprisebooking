require 'test_helper'

class ContractorTest < ActiveSupport::TestCase
  fixtures :invoice_companies
  
  def test_company_fixtures
    company = Contractor.all
    assert_equal 2, company.length
  end
  
  def test_duplicate_code
    company1 = Contractor.new(:code => "CODE", :name => "Name")
    company2 = Contractor.new(:code => "CODE", :name => "Name")
    
    company1.save
    assert_raise(ActiveRecord::StatementInvalid) { company2.save! }     
  end
end
