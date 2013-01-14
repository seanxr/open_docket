class CreateDockets < ActiveRecord::Migration
  def change
    create_table :dockets do |t|
      t.integer :docket_item_id
      t.integer :committee_id
      t.string :creator_id
      t.string :integer
      t.string :updater_id
      t.string :integer
      t.text :note

      t.timestamps
    end

    add_index :dockets, :docket_item_id
    add_index :dockets, :committee_id
    add_index :dockets, [:docket_item_id, :committee_id], unique: true
  end
end
