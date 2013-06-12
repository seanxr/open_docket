class CreateActionMeetings < ActiveRecord::Migration
  def change
    create_table :action_meetings do |t|
      t.integer :meeting_id
      t.integer :creator_id
      t.integer :updater_id
      t.integer :reportable_id
      t.string :reportable_type
      t.integer :position
      t.integer :assigner_id

      t.timestamps
    end
  end
end
