class AddProductToCases < ActiveRecord::Migration
  def self.up
    add_column :cases, :product_id, :integer, :references => 'products'
  end

  def self.down
    remove_column :cases, :product_id
  end
end
