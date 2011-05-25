class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.text :description
      t.string :name
      t.string :itemtype
      t.string :price
      t.string :sku
      t.string :facebook
      t.string :twitter
      t.string :industry
      t.string :email
      t.string :contact_name
      t.string :address
      t.string :phone_number
      t.string :secondary_number
      t.text :url
      t.integer :rating
      t.integer :position
      t.references :user
      t.references :product
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
