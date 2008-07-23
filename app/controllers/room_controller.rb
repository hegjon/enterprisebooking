class RoomController < ApplicationController
  def authorize
    return if receptionist_user? && readonly_action?
    return if receptionist_manager?

    #can only update status!
    if receptionist_user? && update_action?
      params[:room].delete_if { |param| param != "status" }
      return
    end
    
    super
  end
  
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
