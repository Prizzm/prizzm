class CreatePrizzmInvitations < ActiveRecord::Migration
  def self.up
    create_table :prizzm_invitations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :prizzm_invitations
  end
end
