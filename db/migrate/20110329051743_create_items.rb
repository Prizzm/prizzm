class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.text :url
      t.text :description
      t.string :itemtype
      t.integer :rating
      t.integer :position
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
