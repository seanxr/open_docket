class ChangeColumnTypeToDocuments < ActiveRecord::Migration
  def up
    change_column :documents, :submitted_on, :date
  end

  def down
  end
end
