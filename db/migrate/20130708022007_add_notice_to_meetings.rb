class AddNoticeToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :notice, :text
  end
end
