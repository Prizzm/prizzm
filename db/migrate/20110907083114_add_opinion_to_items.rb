class AddOpinionToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :opinion, :string
  end

  def self.down
    remove_column :items, :opinion
  end
end
