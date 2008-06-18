class BookingObserver < ActiveRecord::Observer
  def before_save(booking)
    time_conflict(booking)
    active_conflict(booking)
  end
  
  private
  
  def time_conflict(booking)
    raise "Departure is before arrival" if booking.arrival > booking.departure
    
    b = Booking.first(:conditions => ['id != ifnull(?, -1) and person_id=? and arrival < ? and departure > ?', 
        booking.id, booking.person_id, booking.departure, booking.arrival])

    raise PersonConflict.new(b) if b
    
    if booking.room
      count = Booking.count(:conditions => ['id != ifnull(?, -1) and room_id=? and arrival < ? and departure > ?', 
          booking.id, booking.room_id, booking.departure, booking.arrival])    

      raise "Room conflict" if count >= booking.room.beds 
    end
  end
  
  def active_conflict(booking)
    if booking.status == 20
      b = Booking.first(:conditions => ['id != ifnull(?, -1) and person_id=? and status=20', 
        booking.id, booking.person_id])
      
      raise "Person already active" if b
    end
  end
end