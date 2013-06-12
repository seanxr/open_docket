class AddTypeToMeetingTexts < ActiveRecord::Migration
  def change
    add_column :meeting_texts, :type, :string
    rename_column :meeting_texts, :meeting_text, :text
  end
end
