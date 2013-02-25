# == Schema Information
#
# Table name: action_item_meetings
#
#  id              :integer          not null, primary key
#  aktion_id       :integer
#  item_meeting_id :integer
#  creator_id      :integer
#  updater_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ActionItemMeeting < ActiveRecord::Base
  attr_accessible :creator_id, :aktion_id, :item_meeting_id, :updater_id

  belongs_to :aktion
  belongs_to :item_meeting

  validates :creator_id, presence: true
  validates :updater_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  validates_uniqueness_of :item_meeting_id, :scope => [:aktion_id]


end
