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

  validates :meeting_id, presence: true
  validates :action, presence: true
#  validate :require_one_item

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  belongs_to :meeting
  has_many :action_item_meetings
  has_many :action_meetings
  has_many :item_meetings, :through => :action_item_meetings
  has_many :agendables, :through => :item_meetings
  has_many :committee_meetings, :through => :meeting
  has_many :committees, :through => :committee_meetings

  accepts_nested_attributes_for :action_item_meetings 

  def require_one_item
    errors.add(:base, "You must select at least one item") if action_item_meetings.size < 2
  end

  def committee_names_string
    committees.collect { |id| Committee.find_by_id(id).name }.join('/') 
  end

  def item_names_string
    self.item_meetings.collect { |id| ItemMeeting.find_by_id(id).agendable.name }.join('/')
  end

  def save_with_activity(current_user)
   
    Aktion.transaction do
      self.save!
      activity = Activity.create!(
        :message => "Action at #{meeting.date.strftime("%m/%d/%y")} #{committee_names_string} meeting for item(s): #{self.item_names_string}. #{action}",
        :note => "#{discussion}",
        :activity_type => "NewAction", :date_actual => meeting.date)
      ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id)
      self.item_meetings.each { |i| ActivityLog.create!(
          :activity_id => activity.id, :owner_type => i.agendable_type, :owner_id => i.agendable_id) }
     ActionMeeting.create!(
        :meeting_id => meeting.id, :reportable_id => id, :reportable_type => "Aktion",
        :creator_id => current_user.id, :updater_id => current_user.id)
    end
  end

end
