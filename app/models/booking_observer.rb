class BookingObserver < ActiveRecord::Observer
  def before_save(booking)
    set_default_values(booking)
    time_conflict(booking)
    active_conflict(booking)

    auto_set_profile_categories(booking)
  end
  
  private

  def set_default_values(booking)
    #TODO, set company and name
  end
  
  def time_conflict(booking)
    raise "Departure is before arrival" if booking.arrival > booking.departure
    
    b = Booking.first(:conditions => ['id != ifnull(?, -1) and profile_id=? and arrival < ? and departure > ?', 
        booking.id, booking.profile_id, booking.departure, booking.arrival])

    raise PersonConflict.new(b) if b
    
    #    if booking.room
    #      count = Booking.count(:conditions => ['id != ifnull(?, -1) and room_id=? and arrival < ? and departure > ?', 
    #          booking.id, booking.room_id, booking.departure, booking.arrival])    
    #
    #      raise "Room conflict" if count >= booking.room.beds 
    #    end
  end
  
  def active_conflict(booking)
    if booking.status == 20
      b = Booking.first(:conditions => ['id != ifnull(?, -1) and profile_id=? and status=20', 
          booking.id, booking.profile_id])
      
      raise "Person already active" if b
    end
  end
  
  def auto_set_profile_categories(booking)
    profile = booking.profile
    if profile && booking.status_changed?
      auto_on  = ProfileCategory.all(:conditions => ["auto_on=?", booking.status])
      auto_off = ProfileCategory.all(:conditions => ["auto_off=?", booking.status])
      
      profile.profile_categories << auto_on      
      profile.profile_categories.delete(auto_off)
    end    
  end
  
end