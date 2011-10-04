class CreatePrizzmMailTemplates < ActiveRecord::Migration
  def self.up
    create_table :prizzm_mail_templates do |t|
      t.string :name
      t.string :from
      t.string :subject
      t.text :message_content
      t.references :company

      t.timestamps
    end
  end

  def self.down
    drop_table :prizzm_mail_templates
  end
end
