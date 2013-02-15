class RemoveColumnsFromStatus < ActiveRecord::Migration
  def up
    remove_column :dockets, :creator_id  
    remove_column :dockets, :updater_id
    remove_column :dockets, :integer
  end

  def down
  end
end
