class CampController < ApplicationController

  def authorize
    return if %w{list show}.include?(action_name) 
    
    raise Unauthorized if !is_reseptionist_manager
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
