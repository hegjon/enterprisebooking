class CreatePersonCategories < ActiveRecord::Migration
  def self.up
    create_table :person_categories do |t|
      t.string :name, :null => false
      t.string :abbrivation
      t.integer :order
      t.integer :auto_on
      t.integer :auto_off
    end
    
    create_table :people_person_categories do |t|
      t.references :person
      t.references :person_category
    end
    
    add_index(:people_person_categories, [:person_id, :person_category_id], :unique => true, :name => "index_people_person_categories")
  end

  def self.down
    drop_table :person_categories_person
    drop_table :person_categories
  end
end
