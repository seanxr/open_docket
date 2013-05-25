class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :fname
      t.string :lname
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
