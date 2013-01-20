class CreateCommitteeMeetings < ActiveRecord::Migration
  def change
    create_table :committee_meetings do |t|
      t.integer :meeting_id
      t.integer :committee_id

      t.timestamps
    end
  end
end
