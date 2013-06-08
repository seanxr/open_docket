# == Schema Information
#
# Table name: aktions
#
#  id         :integer          not null, primary key
#  discussion :text
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :integer
#  action     :text
#

class Aktion < ActiveRecord::Base
  attr_accessible :creator_id, :discussion, :meeting_id, :updater_id, :action_item_meetings_attributes, :action

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  belongs_to :meeting
  has_many :action_item_meetings
  has_many :item_meetings, :through => :action_item_meetings
  has_many :agendables, :through => :item_meetings
  has_many :committee_meetings, :through => :meeting
  has_many :committees, :through => :committee_meetings

  accepts_nested_attributes_for :action_item_meetings 

  def committee_names_string
    committees.collect { |id| Committee.find_by_id(id).name }.join('/') 
  end

  def item_names_string
    item_meetings.collect { |id| ItemMeeting.find_by_id(id).agendable.name }.join('/')
  end

  def save_with_activity(current_user)
    # committee_names_string doesn't work in the message string

    Aktion.transaction do
      activity1 = Activity.create!(
        :message => "Action at #{meeting.date} #{committee_names_string} meeting for item(s): #{item_names_string}. #{discussion}",
        :activity_type => "NewAction", :date_actual => meeting.date)
      ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Meeting", :owner_id => meeting.id)
      item_meetings.each { |i| ActivityLog.create!(
          :activity_id => activity1.id, :owner_type => i.agendable_type, :owner_id => i.agendable_id, 
          :creator_id => current_user.id, :updater_id => current_user.id ) }
      self.save!
    end
  end

end
