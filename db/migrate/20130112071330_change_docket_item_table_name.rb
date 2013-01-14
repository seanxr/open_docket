class ChangeDocketItemTableName < ActiveRecord::Migration
  def self.up
    rename_table :docket_items, :items
  end

 def self.down
    rename_table :items, :docket_items
 end
end

