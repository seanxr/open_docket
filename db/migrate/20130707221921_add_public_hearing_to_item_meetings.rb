class AddPublicHearingToItemMeetings < ActiveRecord::Migration
  def change
    add_column :item_meetings, :public_hearing, :boolean
  end
end
