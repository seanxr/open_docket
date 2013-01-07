class AddIndexToCommitteeName < ActiveRecord::Migration
  def change
    add_index :committees, :name, unique: true
  end
end

