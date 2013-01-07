class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :name
      t.text :description
      t.string :shortname
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
