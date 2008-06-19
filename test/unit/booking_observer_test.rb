require File.dirname(__FILE__) + '/../test_helper'

class BookingObserverTest < Test::Unit::TestCase
  fixtures :people, :rooms
  
  def setup
    @booking = Booking.new
    @booking.person = @jonny
    @booking.room = @singleroom1
    @booking.arrival = Time.local(2008, 1, 10, 12, 00)
    @booking.departure = Time.local(2008, 1, 20, 12, 00)
    @booking.status = 10
    @booking.save
  end
  
  def test_normal
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 1, 12, 00)
    b.departure = Time.local(2008, 1, 5, 12, 00)
    b.status = 10
    
    assert_nothing_thrown{ b.save }

    b = Booking.new
    b.person = @jonny
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 25, 12, 00)
    b.departure = Time.local(2008, 1, 28, 12, 00)
    b.status = 10
    
    assert_nothing_thrown{ b.save }   
  end
  
  def test_departure_before_arrival
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom2
    b.arrival = Time.local(2008, 1, 5, 12, 00)
    b.departure = Time.local(2008, 1, 2, 12, 00)
    b.status = 10
    
    assert_raise(RuntimeError) { b.save }    
  end
  
  def test_person_conflict_before  
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom2
    b.arrival = Time.local(2008, 1, 5, 12, 00)
    b.departure = Time.local(2008, 1, 14, 12, 00)
    b.status = 10
    
    assert_raise(PersonConflict) { b.save }
  end
  
  def test_person_conflict_after
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom2
    b.arrival = Time.local(2008, 1, 15, 12, 00)
    b.departure = Time.local(2008, 1, 23, 12, 00)
    b.status = 10
    
    assert_raise(PersonConflict) { b.save }
  end  
  
  def test_person_conflict_in_between
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom2
    b.arrival = Time.local(2008, 1, 13, 12, 00)
    b.departure = Time.local(2008, 1, 17, 12, 00)
    b.status = 10
    
    assert_raise(PersonConflict) { b.save }
  end
  
  def test_person_conflict_full_cover
    b = Booking.new
    b.person = @jonny
    b.room = @singleroom2
    b.arrival = Time.local(2008, 1, 5, 12, 00)
    b.departure = Time.local(2008, 1, 23, 12, 00)
    b.status = 10
    
    assert_raise(PersonConflict) { b.save }
  end   
  
  def test_room_conflict_before  
    b = Booking.new
    b.person = @per
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 5, 12, 00)
    b.departure = Time.local(2008, 1, 13, 12, 00)
    b.status = 10

    assert_raise(RuntimeError) { b.save }
  end
  
  def test_room_conflict_after
    b = Booking.new
    b.person = @per
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 19, 12, 00)
    b.departure = Time.local(2008, 1, 25, 12, 00)
    b.status = 10
    
    assert_raise(RuntimeError) { b.save }
  end
  
  def test_room_conflict_in_between
    b = Booking.new
    b.person = @per
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 12, 12, 00)
    b.departure = Time.local(2008, 1, 15, 12, 00)
    b.status = 10
    
    assert_raise(RuntimeError) { b.save }
  end    
  
  def test_room_conflict_full_cover
    b = Booking.new
    b.person = @per
    b.room = @singleroom1
    b.arrival = Time.local(2008, 1, 1, 12, 00)
    b.departure = Time.local(2008, 1, 25, 12, 00)
    b.status = 10
    
    assert_raise(RuntimeError) { b.save }
  end
  
  def test_double_room
    person = [@per, @pål, @espen]
    count = 0
    person.each do |p|
      b = Booking.new
      b.person = p
      b.room = @doubleroom
      b.arrival = Time.local(2008, 1, 1, 12, 00)
      b.departure = Time.local(2008, 1, 25, 12, 00)
      b.status = 10
      
      count += 1
      if (count <= 2)
        b.save
      else
        assert_raise(RuntimeError) { b.save }
      end
    end  
  end
  
  def test_active_person
    b = @booking.clone
    b.arrival = b.departure + 60*60*24
    b.departure = b.arrival + 60*60*24
    
    @booking.status = 20
    b.status = 20

    assert_nothing_thrown{ @booking.save }
    assert_raise(RuntimeError) { b.save }
  end
  
end