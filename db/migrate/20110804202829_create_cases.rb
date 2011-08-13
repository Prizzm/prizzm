class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
      t.string :title
      t.text :description
      t.date :date
      t.string :case_reference
      t.string :privacy

      t.references :user
      t.references :company
      t.references :item

      t.string :cached_slug
      t.timestamps
    end

    add_index  :cases, :cached_slug, :unique => true
  end

  def self.down
    drop_table :cases
  end
end
