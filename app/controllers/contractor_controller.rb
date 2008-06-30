class ContractorController < ApplicationController
  def list
    companies = Contractor.all   
    ok companies
  end
  
  def list_by_invoice_company
    companies = Contractor.find_all_by_invoice_company_id(:invoice_company_id)
    ok companies
  end
  
  def show
    company = Contractor.find(params[:id])
    ok company
  end

  def create
    company = Contractor.new(params[:contractor])
    company.save!
    created company
  end
  
  def update
    company = Contractor.find(params[:id])
    company.update_attributes!(params[:contractor])
    updated company
  end

  def destroy
    company = Contractor.find(params[:id])
    company.destroy
    destroyed
  end  

end
