class AddIndexToDocketitemsNumber < ActiveRecord::Migration
  def change
    add_index :docket_items, :number, unique: true
  end
end
