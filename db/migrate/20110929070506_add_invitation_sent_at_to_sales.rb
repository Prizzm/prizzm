class AddInvitationSentAtToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :invitation_sent_at, :datetime
  end

  def self.down
    remove_column :sales, :invitation_sent_at
  end
end
