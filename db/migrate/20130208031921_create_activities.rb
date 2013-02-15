class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.date :date_actual
      t.string :person_actual
      t.text :note
      t.string :type
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
