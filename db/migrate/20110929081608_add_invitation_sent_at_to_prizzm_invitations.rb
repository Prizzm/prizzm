class AddInvitationSentAtToPrizzmInvitations < ActiveRecord::Migration
  def self.up
    add_column :prizzm_invitations, :invitation_sent_at, :datetime
  end

  def self.down
    remove_column :prizzm_invitations, :invitation_sent_at
  end
end
