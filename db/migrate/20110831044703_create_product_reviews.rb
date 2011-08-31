class CreateProductReviews < ActiveRecord::Migration
  def self.up
    create_table :product_reviews do |t|
      t.integer  :product_invitation_id
      t.integer  :product_id
      t.text    :content
      t.timestamps
    end
  end

  def self.down
    drop_table :product_reviews
  end
end
