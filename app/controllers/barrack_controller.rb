class BarrackController < ApplicationController
  def authorize
    return if receptionist_user? && readonly_action?
    return if reseptionist_manager?
    
    super
  end
  
  def list
    barracks = Barrack.all
    ok barracks
  end
  
  def list_by_camp
    camp = Camp.find(params[:camp_id])   
    barracks = camp.barracks
    ok barracks
  end
  
  def show
    barrack = Barrack.find(params[:id])
    ok barrack
  end
  
  def create
    barrack = Barrack.new(params[:barrack])
    barrack.save!
    created barrack
  end

  def update
    barrack = Barrack.find(params[:id])
    barrack.update_attributes!(params[:barrack])
    updated barrack
  end
  
  def destroy
    barrack = Barrack.find(params[:id])
    barrack.destroy
    destroyed
  end
  
end
