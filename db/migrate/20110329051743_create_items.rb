class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.text :url
      t.text :review
      t.text :description

      t.string :sku
      t.string :name
      t.string :privacy
      t.string :invitation_status
      t.string :possession_status

      t.integer :rating
      t.integer :position
      t.integer :asking_price

      t.string :cached_slug

      t.references :user
      t.references :product
      t.timestamps
    end

    add_index  :items, :cached_slug, :unique => true
  end

  def self.down
    drop_table :items
  end
end
