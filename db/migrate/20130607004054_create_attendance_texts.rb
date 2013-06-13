class CreateAttendanceTexts < ActiveRecord::Migration
  def change
    create_table :attendance_texts do |t|
      t.text :text
      t.integer :meeting_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
