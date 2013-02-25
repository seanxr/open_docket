# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  opened_on    :date
#  requested_by :text
#  draft        :boolean
#  request      :text
#  address      :text
#  ward         :string(255)
#  creator_id   :integer
#  updater_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reference    :text
#

class Item < ActiveRecord::Base
  attr_accessible :address, :draft, :name, :opened_on, :precinct, :request, 
                  :requested_by, :updater_id, :creator_id, :ward, :reference, 
                  :statuses_attributes

  validates :name, presence: true, length: { maximum: 20 }, 
            uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true
  validates :updater_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  has_many :attachments, :as => :owner
  has_many :documents, :through => :attachments, :as => :owner

  has_many :activity_logs, :as => :owner
  has_many :activities, :through => :activity_logs, :as => :owner

  has_many :statuses, :as => :statused
  accepts_nested_attributes_for :statuses

  has_many :dockets, foreign_key: 'item_id', class_name: 'Docket'
  has_many :committees, through: :dockets, source: :committee
  has_many :item_meetings, :as => :agendable
  has_many :meetings, through: :item_meetings, :as => :agendable

  scope :by_name, lambda{ |name| where(name: name) unless name.nil? }

  def ondocket?(committee)
    #Tests whether or not the item is on the docket for a particular committee

    dockets.find_by_committee_id(committee.id)

  end

  def ondocket!(committee, note)
    # Adds the item to a committee's docket

    committees.find_by_committee_id(committee.id).docket.create!(docket_id: self.id, note: note)

    # Need to fail if the item is already on the committee's docket
    # Need to add activities (on committee and docket item)

  end

  def undocket!(committee)
    # Removes the item from a committee's docket
    # Need to fail if the item is not on the committee's docket

    dockets.find_by_committee_id(committee.id).destroy

    # activities (on committee and docket item)

  end

  def not_docket_committees

    Committee.all.reject { |h| self.committees.include? h }

  end

  def potential_meetings

    # Creates a hash of the meetings after today, where there is an intersection between
    # the committees associated with the item and the committees associated with the meeting.

    item_committees = self.committees.pluck(:committee_id)
    meetings = Meeting.all
    upcoming_meetings = meetings.find_all { |meeting| meeting.date.to_s > Date.today.to_s }
    potential_meetings = upcoming_meetings.find_all { |meeting| (meeting.committees.pluck(:committee_id) & item_committees).any? }	
    potential_meetings

  end

  def current_status
    statuses.last
  end

  def save_with_activities(current_user)
    Item.transaction do
      self.save!
      activity1 = Activity.create!(
        :message => "Item #{name} entered in OpenDocket by #{current_user.name}",
        :activity_type => "NewItem", :date_actual => Date.today)
      ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Item", :owner_id => self.id) 
      activity2 = Activity.create!(
          :message => "Item #{name} opened by __.", :activity_type => "ItemOpen", 
          :date_actual => statuses.last.as_of)
      ActivityLog.create!(:activity_id => activity2.id, :owner_type => "Item", :owner_id => self.id)
    end
  end

end
