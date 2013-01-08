class AddReferenceToDocketItem < ActiveRecord::Migration
  def change
    add_column :docket_items, :reference, :text
  end
end
