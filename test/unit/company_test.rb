require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < ActiveSupport::TestCase
  fixtures :companies
  
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
