class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
      t.string :title
      t.text :description
      t.date :date
      t.string :case_reference
      t.references :user
      t.references :company
      t.references :item

      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
end
