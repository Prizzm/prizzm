class AddTwitterScreeNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :tt_username, :string
  end

  def self.down
    remove_column :users, :tt_username
  end
end
