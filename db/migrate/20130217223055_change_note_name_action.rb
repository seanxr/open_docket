class ChangeNoteNameAction < ActiveRecord::Migration
  def up
    rename_column :actions, :note, :discussion
  end

  def down
  end
end
