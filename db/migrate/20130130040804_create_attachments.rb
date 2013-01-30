class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :document_id
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
