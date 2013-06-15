class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.integer :item_counter

      t.timestamps
    end
  end
end
