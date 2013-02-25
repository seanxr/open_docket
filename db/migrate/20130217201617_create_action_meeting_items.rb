class CreateActionMeetingItems < ActiveRecord::Migration
  def change
    create_table :action_meeting_items do |t|
      t.integer :meeting_id
      t.integer :meeting_item_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
