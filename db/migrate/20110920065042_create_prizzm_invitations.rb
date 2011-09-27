class CreatePrizzmInvitations < ActiveRecord::Migration
  def self.up
    create_table :prizzm_invitations do |t|
      t.references :company
      t.references :product
      t.text       :landing_page
      t.text       :email_content
      t.string     :name
      t.string     :status
      t.string     :metrics
      t.timestamps
    end
  end

  def self.down
    drop_table :prizzm_invitations
  end
end
