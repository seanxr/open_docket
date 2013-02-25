class ChangeMeetingIdNameActionItemMeeting < ActiveRecord::Migration
  def up
    rename_column :action_meeting_items, :meeting_id, :action_id
  end

  def down
  end
end
