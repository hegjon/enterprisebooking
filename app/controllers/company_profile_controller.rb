class CompanyProfileController < ApplicationController
  def list
    profiles = CompanyProfile.all
    ok profiles
  end
  
  def show
    profile = CompanyProfile.find(params[:id])
    ok profile
  end

  def create
    profile = CompanyProfile.new(params[:company_profile])
    profile.save!
    created profile
  end
  
  def update
    profile = CompanyProfile.find(params[:id])
    profile.update_attributes!(params[:company_profile])
    updated profile
  end

  def destroy
    profile = CompanyProfile.find(params[:id])
    profile.destroy
    destroyed
  end
end
