class AddTimeToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :time, :time
  end
end
