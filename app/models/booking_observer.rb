class BookingObserver < ActiveRecord::Observer
  def before_save(booking)
    raise "Departure is before arrival" if booking.arrival > booking.departure
    
    b = Booking.find(:first, :conditions => ['id != ifnull(?, -1) and person_id=? and arrival < ? and departure > ?', 
        booking.id, booking.person_id, booking.departure, booking.arrival])

    raise "Person conflict" if b
    
    b = Booking.find(:first, :conditions => ['id != ifnull(?, -1) and room_id=? and arrival < ? and departure > ?', 
          booking.id, booking.room_id, booking.departure, booking.arrival])    
    
    raise "Room conflict" if b
  end
end