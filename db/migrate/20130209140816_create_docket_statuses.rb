class CreateDocketStatuses < ActiveRecord::Migration
  def change
    create_table :docket_statuses do |t|
      t.integer :docket_id
      t.date :opened_on
      t.integer :opened_by
      t.text :opened_note
      t.date :closed_on
      t.integer :closed_by
      t.text :closed_note

      t.timestamps
    end
  end
end
