require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  fixtures :rooms, :profiles
  
  def setup
    Reservation.new({:profile => @pal, :room => @bigroom}).save!
    Reservation.new({:profile => @per, :room => @bigroom}).save!
    
    assert_equal(2, @bigroom.reservations.size)    
  end
    
  def test_person_is_allowed    
    b = Booking.new
    b.profile = @per
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.periodes << Periode.new do |p|
      p.room = @bigroom
      p.from = b.arrival
      p.to   = b.departure
    end

    b.status = 10
#TODO !!!!! fix the test!!!!!!    
#    assert_nothing_thrown { b.save! }
  end
  
  def test_person_is_not_allowed
    b = Booking.new
    b.profile = @espen
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.periodes << Periode.new do |p|
      p.room = @bigroom
      p.from = b.arrival
      p.to   = b.departure
    end
    b.status = 10
#TODO !!!!! fix the test!!!!!!    
#    assert_raise(RuntimeError) { b.save! }         
  end
  
  def test_person_using_other_room
    b = Booking.new
    b.profile = @pal
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.periodes << Periode.new do |p|
      p.room = @singleroom1
      p.from = b.arrival
      p.to   = b.departure
    end
    b.status = 10
    assert_nothing_thrown { b.save! }    
  end
  
end
