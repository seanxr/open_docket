class AddCreatorUpdaterToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :updater_id, :integer
    add_column :notices, :creator_id, :integer
  end
end
