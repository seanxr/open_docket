class AddAssignerToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :assigner_id, :integer
  end
end
