class AddMeetingIdColumnToAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :meeting_id, :integer
  end
end
