class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :date
      t.integer :room_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
