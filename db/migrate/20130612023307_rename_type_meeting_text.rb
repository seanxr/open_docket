class RenameTypeMeetingText < ActiveRecord::Migration
  def up
    rename_column :meeting_texts, :type, :kind
  end

  def down
  end
end
