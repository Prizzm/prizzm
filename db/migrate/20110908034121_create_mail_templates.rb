class CreateMailTemplates < ActiveRecord::Migration
  def self.up
    create_table :mail_templates do |t|
      t.integer :product_id
      t.string  :name
      t.text    :mail_content
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_templates
  end
end
