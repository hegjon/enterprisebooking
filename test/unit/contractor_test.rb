require 'test_helper'

class ContractorTest < ActiveSupport::TestCase
  fixtures :invoice_company
  
  def test_company_fixtures
    company = Company.find(:all)
    assert_equal 2, company.length
  end
  
  def test_duplicate_code
    company1 = Company.new(:code => "CODE", :name => "Name")
    company2 = Company.new(:code => "CODE", :name => "Name")
    
    company1.save
    assert_raise(ActiveRecord::StatementInvalid) { company2.save! }     
  end
end
