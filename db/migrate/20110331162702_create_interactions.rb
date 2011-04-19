class CreateInteractions < ActiveRecord::Migration
  def self.up
    create_table :interactions do |t|
      t.references :item
      t.datetime :time_start
      t.datetime :time_end
      t.string :contact
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :interactions
  end
end
