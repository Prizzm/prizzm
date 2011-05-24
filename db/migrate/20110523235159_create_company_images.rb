class CreateCompanyImages < ActiveRecord::Migration
  def self.up
    create_table :company_images do |t|
      t.references :company
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :company_images
  end
end
