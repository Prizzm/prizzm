class AddMailTemplateIdToProductInvitations < ActiveRecord::Migration
  def self.up
    add_column :product_invitations, :mail_template_id, :integer
  end

  def self.down
    remove_column :product_invitations, :mail_template_id
  end
end
