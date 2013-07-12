class CreatePublicHearings < ActiveRecord::Migration
  def change
    create_table :public_hearings do |t|
      t.integer :meeting_id
      t.text :publication

      t.timestamps
    end
  end
end
