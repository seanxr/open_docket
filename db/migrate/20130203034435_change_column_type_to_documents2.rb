class ChangeColumnTypeToDocuments2 < ActiveRecord::Migration
  def up
    remove_column :documents, :submitted_on
  end

  def down
  end
end
