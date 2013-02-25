class RenameActionToAktion < ActiveRecord::Migration
  def up
    rename_table :actions, :aktions
  end

  def down
  end
end
