class SubcontractorController < ApplicationController
  def authorize
    return if receptionist_user? && readonly_action?
    return if receptionist_manager?
    
    super
  end
  
  def list
    companies = Subcontractor.all   
    ok companies
  end
  
  def list_by_contractor
    companies = Subcontractor.find_all_by_contractor_id(:contractor_id)
    ok companies
  end
  
  def show
    company = Subcontractor.find(params[:id])
    ok company
  end

  def create
    company = Subcontractor.new(params[:subcontractor])
    company.save!
    created company
  end
  
  def update
    company = Subcontractor.find(params[:id])
    company.update_attributes!(params[:subcontractor])
    updated company
  end

  def destroy
    company = Subcontractor.find(params[:id])
    company.destroy
    destroyed
  end  
end
