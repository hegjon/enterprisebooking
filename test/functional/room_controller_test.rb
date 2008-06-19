require File.dirname(__FILE__) + '/../test_helper'

class RoomControllerTest < ActionController::TestCase
  fixtures :people, :rooms
  
  def setup
    #@jonny.reservation.add(@singleroom1)
  end
  
  def test_truth
    assert true
  end
end
