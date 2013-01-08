class CreateDocketItems < ActiveRecord::Migration
  def change
    create_table :docket_items do |t|
      t.string :number
      t.date :opened_on
      t.text :requested_by
      t.boolean :draft
      t.text :request
      t.text :address
      t.string :ward
      t.string :precinct
      t.integer :creator_id 
      t.integer :updater_id

      t.timestamps
    end
  end
end
