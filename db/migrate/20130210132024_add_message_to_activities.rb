class AddMessageToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :message, :text
  end
end
