require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  fixtures :rooms, :people
  
  def setup
    Reservation.new({:person => @pal, :room => @bigroom}).save!
    Reservation.new({:person => @per, :room => @bigroom}).save!
    
    assert_equal(2, @bigroom.reservations.size)    
  end
    
  def test_person_is_allowed    
    b = Booking.new
    b.person = @per
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.room = @bigroom
    b.status = 10
#TODO !!!!! fix the test!!!!!!    
#    assert_nothing_thrown { b.save }
  end
  
  def test_person_is_not_allowed
    b = Booking.new
    b.person_id = 4 #@espen
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.room = @bigroom
    b.status = 10
#TODO !!!!! fix the test!!!!!!    
#    assert_raise(RuntimeError) { b.save }         
  end
  
  def test_person_using_other_room
    b = Booking.new
    b.person = @pal
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.room = @singleroom
    b.status = 10
    assert_nothing_thrown { b.save }    
  end
  
end
