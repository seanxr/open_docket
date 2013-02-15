class AddColumnsToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :creators_id, :integer
    add_column :statuses, :updaters_id, :integer
  end
end
