class AddImageToPeople < ActiveRecord::Migration
  def change
    add_column :people, :image_url, :text
  end
end
