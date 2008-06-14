class CompanyController < ApplicationController
  def list
    companies = Company.all   
    ok companies
  end
  
  def show
    company = Company.find(params[:id])
    ok company
  end

  def create
    company = Company.new(params[:company])
    company.save!
    created company
  end
  
  def update
    company = Company.find(params[:id])
    company.update_attributes!(params[:company])
    updated company
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    destroyed
  end
end
