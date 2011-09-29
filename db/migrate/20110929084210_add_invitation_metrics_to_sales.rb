class AddInvitationMetricsToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :landing_page_visited, :boolean
    add_column :sales, :wrote_review, :boolean
    add_column :sales, :logged_in_with_fb, :boolean
    add_column :sales, :logged_in_with_prizzm, :boolean
    add_column :sales, :shared_item_to_fb, :boolean
  end

  def self.down
    remove_column :sales, :landing_page_visited
    remove_column :sales, :wrote_review
    remove_column :sales, :logged_in_with_fb
    remove_column :sales, :logged_in_with_prizzm
    remove_column :sales, :shared_item_to_fb
  end
end
