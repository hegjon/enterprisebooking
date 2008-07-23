class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :password, :null => false, :limit => 40
      t.string :type, :null => false
    end
    
    add_index(:users, :username, :unique => true)
  end

  def self.down
    drop_table :users
  end
end
