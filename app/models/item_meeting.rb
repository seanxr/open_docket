# == Schema Information
#
# Table name: item_meetings
#
#  id             :integer          not null, primary key
#  item_id        :integer
#  meeting_id     :integer
#  creator_id     :integer
#  updater_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  agendable_id   :integer
#  agendable_type :string(255)
#  position       :integer
#

class ItemMeeting < ActiveRecord::Base
  attr_accessible :agendable_id, :agendable_type, :creator_id, :item_id, :meeting_id, :updater_id

  has_one :meeting
  has_one :agendable
  has_one :action_item_meeting
  has_one :aktion, :through => :action_item_meeting

  belongs_to :meeting
  belongs_to :agendable, :polymorphic => true

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :agendable_id, presence: true
  validates :agendable_type, presence: true
  validates :meeting_id, presence: true

  # Needs to be expanded for uniqueness on id and type

  validates_uniqueness_of :meeting_id, :scope => [:agendable_id, :agendable_type]

  def agendable_name
    agendable.name
  end

  def destroy_with_activities(current_user)
    ItemMeeting.transaction do
      activity1 = Activity.create!(
        :message => "Item #{agendable.name} removed from #{meeting.name} #{meeting.committee_names_string} meeting",
        :activity_type => "AgendableRemovedFromMeeting", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity1.id, :owner_type => agendable.class.name, :owner_id => agendable.id) 
        ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Meeting", :owner_id => meeting_id)
        for committee in meeting.committees do
          ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Committee", :owner_id => committee.id)
        end
      self.destroy
    end
  end

end
