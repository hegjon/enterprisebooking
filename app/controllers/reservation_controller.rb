class ReservationController < ApplicationController
  def list
    reservations = Reservation.all
    ok reservations
  end
  
  def list_by_room
    room = Room.find(params[:room_id])
    people = room.reservations
    ok people
  end
  
  def list_by_person
    person = Person.find(params[:person_id])
    rooms = person.reservations
    ok rooms    
  end
  
  def show
    reservation = Reservation.find(params[:id])
    ok reservation
  end

  def create
    reservation = Reservation.new(params[:reservation])
    reservation.save!
    created reservation
  end
  
  def update
    reservation = Reservation.find(params[:id])
    reservation.update_attributes!(params[:person])
    updated reservation
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    destroyed
  end
end
