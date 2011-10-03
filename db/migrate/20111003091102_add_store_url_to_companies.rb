class AddStoreUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :store_url, :string
  end

  def self.down
    remove_column :companies, :store_url
  end
end
