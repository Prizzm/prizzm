class CreateInteractions < ActiveRecord::Migration
  def self.up
    create_table :interactions do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.integer :rating
      t.string :contact
      t.boolean :shared_facebook
      t.boolean :shared_twitter
      t.text :description

      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :interactions
  end
end
