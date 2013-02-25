class AddColumnsToDockets < ActiveRecord::Migration
  def change
    add_column :dockets, :as_of, :date
  end
end
