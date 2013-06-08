class AddActionToAktions < ActiveRecord::Migration
  def change
    add_column :aktions, :action, :text
  end
end
