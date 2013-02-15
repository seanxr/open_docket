class AddActualDateToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :as_of, :date
  end
end
