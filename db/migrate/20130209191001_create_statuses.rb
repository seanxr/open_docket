class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :code
      t.string :statused_type
      t.integer :statused_id
      t.integer :statuser_id
      t.integer :updater_id
      t.integer :creator_id
      t.date :as_of

      t.timestamps
    end
  end
end
