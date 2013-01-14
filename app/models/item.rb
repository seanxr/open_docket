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

  def ondocket?(committee)
    dockets.find_by_committee_id(committee.id)
  end

  def ondocket!(committee, note)
    committees.find_by_committee_id(committee.id).docket.create!(docket_id: self.id, note: note)
    # activities (on committee and docket item)
  end

  def undocket!(committee)
    dockets.find_by_committee_id(committee.id).destroy
    # activities (on committee and docket item)
  end

end
