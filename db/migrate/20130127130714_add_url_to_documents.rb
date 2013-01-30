class AddUrlToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :URL, :string
  end
end
