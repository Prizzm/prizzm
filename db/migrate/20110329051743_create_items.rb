class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.text :review
      t.integer :rating
      t.string :sku

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
