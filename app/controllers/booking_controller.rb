class BookingController < ApplicationController
  def authorize    
    return if receptionist?
    
    super
  end
  
  def list
    bookings = Booking.all
    ok bookings
  end
  
  def list_by_room
    room = Room.find(params[:room_id])
    bookings = room.bookings
    ok bookings
  end
  
  def list_by_arrival
    #TODO dont use the index
    bookings = Booking.all("trunc(arrival)=trunc(?)", params[:arrival])
    ok bookings
  end
  
  def list_by_departure
    #TODO dont use the index
    bookings = Booking.all("trunc(departure)=trunc(?)", params[:departure])
    ok bookings    
  end
  
  def create
    booking = Booking.new(params[:booking])
    booking.save!
    created booking
  end
  
  def update
    booking = Booking.find(params[:id])
    booking.update_attributes!(params[:booking])
    updated booking
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    destroyed
  end 
end
