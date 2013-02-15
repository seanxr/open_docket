class ChangeColumnNameForActivity < ActiveRecord::Migration
  def up
    rename_column :activities, :type, :activity_type
  end

  def down
  end
end
