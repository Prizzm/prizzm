class AddColumnsToProductInvitations < ActiveRecord::Migration
  def self.up
    add_column :product_invitations, :product_id,:integer
    add_column :product_invitations, :first_name,:string
    add_column :product_invitations, :last_name,:string
    add_column :product_invitations, :email,:string
    add_column :product_invitations, :purchase_date,:date
    add_column :product_invitations, :amount,:string
    add_column :product_invitations, :sent,:string
    add_column :product_invitations, :accepted,:string
  end

  def self.down
    remove_column :product_invitations, :product_id
    remove_column :product_invitations, :first_name
    remove_column :product_invitations, :last_name
    remove_column :product_invitations, :email
    remove_column :product_invitations, :purchase_date
    remove_column :product_invitations, :amount
    remove_column :product_invitations, :sent
    remove_column :product_invitations, :accepted
  end
end
