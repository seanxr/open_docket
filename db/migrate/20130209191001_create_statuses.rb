class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :code
      t.string :statused_type
      t.integer :statused_id
      t.integer :statused_by
      t.integer :created_by

      t.timestamps
    end
  end
end
