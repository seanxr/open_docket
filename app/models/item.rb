# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  number       :string(255)
#  opened_on    :date
#  requested_by :text
#  draft        :boolean
#  request      :text
#  address      :text
#  ward         :string(255)
#  precinct     :string(255)
#  creator_id   :integer
#  updater_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reference    :text
#

class Item < ActiveRecord::Base
  attr_accessible :address, :draft, :number, :opened_on, :precinct, :request, :requested_by, :updater_id, :creator_id, :ward, :reference

  validates :number, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true
  validates :updater_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  has_many :dockets, foreign_key: 'item_id', class_name: 'Docket'
  has_many :committees, through: :dockets, source: :committee
  has_many :item_meetings
  has_many :meetings, through: :item_meetings, source: :meeting

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

  def potentialmeetings

    # Creates an array (hash?) of the meetings after today, where there is an intersection between
    # the committees associated with the item and the committees associated with the meeting.

    itemcommittees = self.committees.pluck(:committee_id)
    meetings = Meeting.all
    upcomingmeetings = meetings.find_all { |meeting| meeting.date.to_s > Date.today.to_s }
    potentialmeetings = upcomingmeetings.find_all { |meeting| (meeting.committees.pluck(:committee_id) & itemcommittees).any? }	
    potentialmeetings

  end



end
