class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.text :note
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
