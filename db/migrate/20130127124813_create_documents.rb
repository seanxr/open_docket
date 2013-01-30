class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :doc_type
      t.string :name
      t.string :description
      t.string :submitted_by
      t.string :submitted_on
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
