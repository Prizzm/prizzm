class AddProfilesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string 
    add_column :users, :last_name, :string 
    add_column :users, :phone_number, :string 
    add_column :users, :photo, :string 
    add_column :users, :location, :string 
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone_number
    remove_column :users, :photo
    remove_column :users, :location
  end
end
