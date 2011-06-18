class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.text :review
      t.text :url
      t.integer :rating
      t.string :sku
      t.string :privacy
      t.string :invitation_status

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
