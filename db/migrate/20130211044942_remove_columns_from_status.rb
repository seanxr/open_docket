class RemoveColumnsFromStatus < ActiveRecord::Migration
  def up
    remove_column :status, :creator_id  
    remove_column :status, :updater_id
    remove_column :status, :integer
  end

  def down
  end
end
