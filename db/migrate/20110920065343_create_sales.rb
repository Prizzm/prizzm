class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.string :price
      t.datetime :date
      t.references :prizzm_invitation
      t.references :client
      t.string :invitation_status

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
