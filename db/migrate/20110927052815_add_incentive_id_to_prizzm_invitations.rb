class AddIncentiveIdToPrizzmInvitations < ActiveRecord::Migration
  def self.up
    add_column :prizzm_invitations, :incentive_id, :integer
  end

  def self.down
    remove_column :prizzm_invitations, :incentive
  end
end
