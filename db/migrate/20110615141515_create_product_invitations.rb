class CreateProductInvitations < ActiveRecord::Migration
  def self.up
    create_table :product_invitations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :product_invitations
  end
end
