class BookingController < ApplicationController
  def list
    bookings = Booking.all
    ok bookings
  end
  
  def list_by_room
    room = Room.find(params[:room_id])
    bookings = room.bookings
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
