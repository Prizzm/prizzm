class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.text :address
      t.string :address_type
      t.string :description
      t.references :company

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
