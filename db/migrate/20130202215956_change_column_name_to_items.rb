class ChangeColumnNameToItems < ActiveRecord::Migration
  def up
    rename_column :items, :number, :name
    remove_column :items, :precinct
  end

  def down
  end
end
