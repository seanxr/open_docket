class CreateItemMeetings < ActiveRecord::Migration
  def change
    create_table :item_meetings do |t|
      t.integer :item_id
      t.integer :meeting_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
