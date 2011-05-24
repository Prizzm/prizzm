class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :company

      t.string :name
      t.string :type
      t.string :upc

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
