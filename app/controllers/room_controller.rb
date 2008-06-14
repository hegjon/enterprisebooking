class RoomController < ApplicationController
  def list
    rooms = Room.all
    ok rooms
  end
  
  def list_by_barrack
    barrack = Barrack.find(params[:barrack_id])
    rooms = barrack.rooms
    ok rooms
  end
  
  def show
    room = Room.find(params[:id])
    ok room
  end
  
  def create
    room = Room.new(params[:room])
    room.save!
    created room
  end
  
  def update
    room = Room.find(params[:id])
    room.update_attributes!(params[:room])
    updated room
  end
  
  def destroy
    room = Room.find(params[:id])
    room.destroy
    destroyed
  end

end
