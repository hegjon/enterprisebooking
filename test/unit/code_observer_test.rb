require 'test_helper'

class CodeObserverTest < Test::Unit::TestCase
  def test_long_code
    company = Contractor.new
    company.code = "long_code_name_aaaaaaaaa"
    company.name = "company"

    assert_raise(RuntimeError) { company.save! }  
  end
  
  def test_camp_upper
    camp = Camp.new
    camp.code = "asd2"
    camp.name = "Camp"
    camp.save!
    assert_equal("ASD2", camp.code)
  end

  def test_company_upper
    company = Contractor.new
    company.code = "asd2"
    company.name = "Camp"
    company.save!
    assert_equal("ASD2", company.code)
  end
  
end
