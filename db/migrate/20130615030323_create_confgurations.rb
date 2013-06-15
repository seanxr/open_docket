class CreateConfgurations < ActiveRecord::Migration
  def change
    create_table :confgurations do |t|
      t.integer :item_counter

      t.timestamps
    end
  end
end
