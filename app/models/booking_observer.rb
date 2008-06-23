class BookingObserver < ActiveRecord::Observer
  def before_save(booking)
    time_conflict(booking)
    active_conflict(booking)
    reservation_conflict(booking)
    
    auto_set_room_categories(booking)
    auto_set_person_categories(booking)
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
  
  def reservation_conflict(booking)
    room = booking.room
    if booking.room_id_changed? && room && !room.reservations.empty?
      raise "Reservaton conflict" unless room.reservations.include?(booking.person);
    end
  end
  
  def auto_set_room_categories(booking)
    room = booking.room
    if room && booking.status_changed?
      auto_on  = RoomCategory.all(:conditions => ["auto_on=?", booking.status])
      auto_off = RoomCategory.all(:conditions => ["auto_off=?", booking.status])
      
      room.room_categories << auto_on      
      room.room_categories.delete(auto_off)
    end
  end
  
  def auto_set_person_categories(booking)
    person = booking.person
    if person && booking.status_changed?
      auto_on  = PersonCategory.all(:conditions => ["auto_on=?", booking.status])
      auto_off = PersonCategory.all(:conditions => ["auto_off=?", booking.status])
      
      person.person_categories << auto_on      
      person.person_categories.delete(auto_off)
    end    
  end
  
end