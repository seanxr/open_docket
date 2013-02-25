class RenameActionIdColumnInActionItemMeetings < ActiveRecord::Migration
  def up
    rename_column :action_item_meetings, :action_id, :aktion_id
  end

  def down
  end
end
