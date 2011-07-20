class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
        t.string :name
      t.string :email
      t.string :address
      t.string :phone_number
      t.string :secondary_number
      t.text :url
      t.string :industry
      t.string :contact_name

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
