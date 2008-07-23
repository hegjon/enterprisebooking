class ProfileController < ApplicationController
  def authorize
    return if receptionist?
    
    super
  end
  
  def list
    profiles = Profile.all
    ok profiles
  end
  
  def show
    profile = Profile.find(params[:id])
    ok profile
  end

  def create
    profile = Profile.new(params[:profile])
    profile.save!
    created profile
  end
  
  def update
    profile = Profile.find(params[:id])
    profile.update_attributes!(params[:profile])
    updated profile
  end

  def destroy
    profile = Profile.find(params[:id])
    profile.destroy
    destroyed
  end
end
