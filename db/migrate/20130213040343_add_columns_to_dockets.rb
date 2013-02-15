class AddColumnsToDockets < ActiveRecord::Migration
  def change
    add_column :dockets, :creator_id, :integer
    add_column :dockets, :updater_id, :integer
  end
end
