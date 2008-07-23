class CampController < ApplicationController
  def authorize
    return if receptionist_user? && readonly_action?
    return if receptionist_manager?
        
    super
  end
  
  def list
    camps = Camp.all
    ok camps
  end
  
  def show
    camp = Camp.find(params[:id])
    ok camp
  end

  def create    
    camp = Camp.new(params[:camp])
    camp.save!
    created camp
  end
  
  def update
    camp = Camp.find(params[:id])
    camp.update_attributes!(params[:camp])
    updated camp
  end

  def destroy
    camp = Camp.find(params[:id])
    camp.destroy
    destroyed
  end
end
