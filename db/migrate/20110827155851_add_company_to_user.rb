class AddCompanyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company_id, :int
  end

  def self.down
  end
end
