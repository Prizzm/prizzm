class CreateItemImages < ActiveRecord::Migration
  def self.up
    create_table :item_images do |t|
      t.references :item
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :item_images
  end
end
