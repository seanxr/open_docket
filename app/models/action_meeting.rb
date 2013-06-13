# == Schema Information
#
# Table name: action_meetings
#
#  id              :integer          not null, primary key
#  meeting_id      :integer
#  creator_id      :integer
#  updater_id      :integer
#  reportable_id   :integer
#  reportable_type :string(255)
#  position        :integer
#  assigner_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  aktion_id       :integer
#

class ActionMeeting < ActiveRecord::Base
  attr_accessible :assigner_id, :creator_id, :meeting_id, :position, :reportable_id, :reportable_type, :updater_id, :aktion_id

 # has_one :meeting
 # has_one :reportable
 # has_many :action_item_meeting
 # has_many :aktions, :through => :action_item_meeting
  belongs_to :aktion
  
  belongs_to :meeting
  belongs_to :reportable, :polymorphic => true

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
  belongs_to :assigner,    :class_name => 'Person'

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
#  validates :meeting_id, presence: true
#  validates :aktion_id, presence: true
  # Needs to be expanded for uniqueness on id and type

  validates_uniqueness_of :meeting_id, :scope => [:reportable_id, :reportable_type]

  def reportable_name
    reportable.name
  end

  def destroy_with_activities(current_user)
    ActionMeeting.transaction do
      activity = Activity.create!(
        :message => "Action #{reportable.name} removed from #{meeting.name} #{meeting.committee_names_string} meeting",
        :activity_type => "ReportableRemovedFromMeeting", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => agendable.class.name, :owner_id => agendable.id) 
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting_id)
        for committee in meeting.committees do
          ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Committee", :owner_id => committee.id)
        end
      self.destroy
    end
  end
end
