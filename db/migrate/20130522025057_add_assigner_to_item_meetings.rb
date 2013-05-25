class AddAssignerToItemMeetings < ActiveRecord::Migration
  def change
    add_column :item_meetings, :assigner_id, :integer
  end
end
