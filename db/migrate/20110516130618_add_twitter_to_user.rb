class AddTwitterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tt_token, :string
    add_column :users, :tt_secret, :string
  end

  def self.down
    remove_column :users, :tt_secret
    remove_column :users, :tt_token
  end
end
