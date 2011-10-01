class CreateCaseFiles < ActiveRecord::Migration
  def self.up
    create_table :case_files do |t|
      t.integer :case_id
      t.string :casefile
      t.string :privacy

      t.timestamps
    end
  end

  def self.down
    drop_table :case_files
  end
end
