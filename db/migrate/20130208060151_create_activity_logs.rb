class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :activity_id
      t.string :owner_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
