class AddAssignerToDockets < ActiveRecord::Migration
  def change
    add_column :dockets, :assigner_id, :integer
  end
end
