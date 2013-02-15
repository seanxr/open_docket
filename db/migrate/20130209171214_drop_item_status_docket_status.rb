class DropItemStatusDocketStatus < ActiveRecord::Migration
  def up
    drop_table :item_statuses
    drop_table :docket_statuses
  end

  def down
  end
end
