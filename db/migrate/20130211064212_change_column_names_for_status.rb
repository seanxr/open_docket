class ChangeColumnNamesForStatus < ActiveRecord::Migration
  def up
    rename_column :statuses, :updaters_id, :updater_id
    rename_column :statuses, :creators_id, :creator_id
  end

  def down
  end
end
