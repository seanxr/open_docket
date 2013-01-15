class AddCreatorUpdaterToSites < ActiveRecord::Migration
  def change
    add_column :sites, :creator_id, :integer
    add_column :sites, :updater_id, :integer
  end
end
