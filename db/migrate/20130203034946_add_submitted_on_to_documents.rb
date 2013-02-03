class AddSubmittedOnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :submitted_on, :date
  end
end
