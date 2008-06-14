require File.dirname(__FILE__) + '/../test_helper'

class CampTest < ActiveSupport::TestCase
  fixtures :camps
  
  def test_camp_fixtures
    camps = Camp.find(:all)
    assert_equal 2, camps.length
  end
  
  def test_duplicate_code
    camp1 = Camp.new(:code => "CODE", :name => "Name")
    camp2 = Camp.new(:code => "CODE", :name => "Name")
    
    camp1.save!
    assert_raise(ActiveRecord::StatementInvalid) { camp2.save! }     
  end
  
  def test_long_code
    camp = Camp.new
    camp.code = "long_code_name_aaaaaaaaaaaa"
    camp.name = "camp"

    assert_raise(RuntimeError) { camp.save! }  
  end
  
end
