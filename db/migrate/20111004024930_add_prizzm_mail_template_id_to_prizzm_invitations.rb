class AddPrizzmMailTemplateIdToPrizzmInvitations < ActiveRecord::Migration
  def self.up
    add_column :prizzm_invitations, :prizzm_mail_template_id, :integer
  end

  def self.down
    remove_column :prizzm_invitations, :prizzm_mail_template_id
  end
end
