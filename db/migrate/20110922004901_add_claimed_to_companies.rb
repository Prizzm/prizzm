class AddClaimedToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :claimed, :boolean, {:default => true, :null => false}
  end

  def self.down
    remove_column :companies, :claimed
  end
end
