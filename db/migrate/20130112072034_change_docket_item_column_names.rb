class ChangeDocketItemColumnNames < ActiveRecord::Migration
  def up
    rename_column :dockets, :docket_item_id, :item_id
  end

  def down
   rename_column :dockets, :item_id, :docket_item_id
  end
end
