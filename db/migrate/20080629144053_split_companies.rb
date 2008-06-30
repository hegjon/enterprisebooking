class SplitCompanies < ActiveRecord::Migration
  def self.up    
    create_table :invoice_companies do |t|
      t.string :code, :null => false, :limit => 10
      t.string :name, :null => false
    end

    rename_table(:companies, :contractors)
    add_column(:contractors, :invoice_company_id, :integer)
    
    create_table :subcontractors do |t|
      t.string :code, :null => false, :limit => 10
      t.string :name, :null => false
      t.references :contractor, :null => false
    end    
  end

  def self.down
    drop_table :invoice_companies
    drop_table :subcontrators
    rename_table(:contractors, :companies)
  end
end
