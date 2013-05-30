# == Schema Information
#
# Table name: meeting_texts
#
#  id              :integer          not null, primary key
#  meeting_id      :integer
#  meeting_text    :text
#  action_required :integer
#  creator_id      :integer
#  updater_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class MeetingText < ActiveRecord::Base
  attr_accessible :action_required, :creator_id, :meeting_id, :meeting_text, :updater_id

  belongs_to :meeting

  validates :creator_id, presence: true
  validates :updater_id, presence: true
  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  has_one :item_meeting, :as => :agendable

  def save_with_activity 

    MeetingText.transaction do
      self.save!
      @item_meeting = ItemMeeting.create!(:meeting_id => meeting_id, :agendable_type => "MeetingText", :agendable_id => id)
      activity1 = Activity.create!(
        :message => "Meeting text added to #{meeting.date} meeting: #{meeting_text}",
        :activity_type => "NewMeetingText", :date_actual => Today.date)
        ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Meeting", :owner_id => meeting.id)
    end
  end

  def name
    if meeting_text.length > 50
      "Meeting text: "+ meeting_text[0..50]+"..."
    else
      "Meeting text: "+ meeting_text
    end
  end


end
