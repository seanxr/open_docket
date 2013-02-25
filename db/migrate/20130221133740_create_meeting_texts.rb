class CreateMeetingTexts < ActiveRecord::Migration
  def change
    create_table :meeting_texts do |t|
      t.integer :meeting_id
      t.text :meeting_text
      t.integer :action_required
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end
end
