class ChangeCreatorColumnStatus < ActiveRecord::Migration
  def up
    rename_column :statuses, :created_by, :creator_id
    rename_column :statuses, :statused_by, :statuser_id
  end

  def down
  end
end
