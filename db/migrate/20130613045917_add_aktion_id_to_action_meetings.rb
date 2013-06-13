class AddAktionIdToActionMeetings < ActiveRecord::Migration
  def change
    add_column :action_meetings, :aktion_id, :integer
  end
end
