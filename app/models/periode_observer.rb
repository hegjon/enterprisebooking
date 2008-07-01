class PeriodeObserver < ActiveRecord::Observer

  def before_save(periode)    
    time_conflict(periode)    
    reservation_conflict(periode)
    
    auto_set_room_categories(periode)
  end
  
  private
  
  def time_conflict(periode)
    count = Periode.count(:conditions => ['id != ifnull(?, -1) and room_id=? and `from` < ? and `to` > ?', 
        periode.id, periode.room_id, periode.to, periode.from])    

    raise "Room conflict" if count >= periode.room.beds     
  end
  
  def reservation_conflict(periode)
    room = periode.room
    if periode.room_id_changed? && room && !room.reservations.empty?
      raise "Reservation conflict" unless room.reservations.include?(periode.booking.profile);
    end
  end

  def auto_set_room_categories(periode)
    room = periode.room
    
    if room && periode.room_id_changed?
      auto_on  = RoomCategory.all(:conditions => ["auto_on=?", periode.booking.status])
      auto_off = RoomCategory.all(:conditions => ["auto_off=?", periode.booking.status])
      
      room.room_categories << auto_on      
      room.room_categories.delete(auto_off)
    end
  end
  
end
