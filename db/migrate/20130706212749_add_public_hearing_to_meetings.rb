class AddPublicHearingToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :public_hearing, :boolean
  end
end
