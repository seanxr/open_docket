class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :floor
      t.string :number
      t.integer :capacity
      t.string :notes
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
