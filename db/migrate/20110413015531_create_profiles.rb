class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :photo
      t.string :location
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
