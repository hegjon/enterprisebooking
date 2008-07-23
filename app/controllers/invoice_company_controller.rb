class InvoiceCompanyController < ApplicationController
  def authorize
    return if is_receptionist_user && readonly_action?
    return if is_receptionist_manager
    
    raise Unauthorized
  end
  
  def list
    companies = InvoiceCompany.all
    ok companies
  end
  
  def show
    company = InvoiceCompany.find(params[:id])
    ok company
  end

  def create
    company = InvoiceCompany.new(params[:invoice_company])
    company.save!
    created company
  end
  
  def update
    company = InvoiceCompany.find(params[:id])
    company.update_attributes!(params[:invoice_company])
    updated company
  end

  def destroy
    company = InvoiceCompany.find(params[:id])
    company.destroy
    destroyed
  end  
end
