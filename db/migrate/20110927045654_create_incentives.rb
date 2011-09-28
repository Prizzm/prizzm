class CreateIncentives < ActiveRecord::Migration
  def self.up
    create_table :incentives do |t|
      t.references :company
      t.text :description
      t.datetime :expiration
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :incentives
  end
end
