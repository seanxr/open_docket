class RenameMeetingItemIdColumnInActionItemMeeting < ActiveRecord::Migration
  def up
    rename_table :action_meeting_items, :action_item_meetings
    rename_column :action_item_meetings, :meeting_item_id, :item_meeting_id
  end

  def down
  end
end
