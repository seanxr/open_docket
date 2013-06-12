# == Schema Information
#
# Table name: meeting_texts
#
#  id              :integer          not null, primary key
#  meeting_id      :integer
#  text            :text
#  action_required :integer
#  creator_id      :integer
#  updater_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  kind            :string(255)
#

class MeetingText < ActiveRecord::Base
  attr_accessible :action_required, :creator_id, :kind, :meeting_id, :text, :updater_id

  belongs_to :meeting

  validates :kind, presence: true
  validates :meeting_id, presence: true
  validates :text, presence: true
  validates :creator_id, presence: true
  validates :updater_id, presence: true
  
  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  has_one :item_meeting, :as => :agendable

  def save_with_activity 

    MeetingText.transaction do
      self.save!
      if kind == "Agenda"
        @item_meeting = ItemMeeting.create!(:meeting_id => meeting_id, :agendable_type => "MeetingText", :agendable_id => id)
      elsif kind == "Report"
        @action_meeting = ActionMeeting.create!(:meeting_id => meeting_id, :reportable_type => "MeetingText", :reportable_id => id)
      end
      activity = Activity.create!(
        :message => "#{kind} text added to #{meeting.date} meeting",
        :note => text,
        :activity_type => "NewMeetingText", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id)
    end
  end

  def name
    if text.length > 50
      kind + " text: "+ text[0..40]+"..."
    else
      kind + " text: "+ text
    end
  end


end
