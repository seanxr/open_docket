class AddCreatorUpdaterToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :creator_id, :integer
    add_column :memberships, :updater_id, :integer
  end
end
