class AddWorkflowStateToCases < ActiveRecord::Migration
  def self.up
    add_column :cases, :workflow_state, :string
  end

  def self.down
    remove_column :cases, :workflow_state
  end
end
