require File.dirname(__FILE__) + '/../test_helper'

class CampControllerTest < ActionController::TestCase
  fixtures :camps

  def setup
    @controller = CampController.new    
  end
  
  def test_camp_fixtures
    @controller.list()
  end
  
  def test_duplicate_code

  end
  
  def test_long_code

  end

end
