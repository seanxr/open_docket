class AddColumnsToItemMeetings < ActiveRecord::Migration
  def change
    add_column :item_meetings, :agendable_id, :integer
    add_column :item_meetings, :agendable_type, :string
    add_column :item_meetings, :position, :integer
  end
end
