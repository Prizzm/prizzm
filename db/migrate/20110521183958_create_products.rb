class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :company

      t.string :name
      t.string :product_type
      t.string :price
      t.string :upc
      t.text    :url
      t.text    :description
      t.integer :rating

      t.string :cached_slug
      t.timestamps
    end
    
    add_index  :products, :cached_slug, :unique => true
  end

  def self.down
    drop_table :products
  end
end
