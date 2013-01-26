# == Schema Information
#
# Table name: item_meetings
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  meeting_id :integer
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ItemMeeting < ActiveRecord::Base
  attr_accessible :creator_id, :item_id, :meeting_id, :updater_id

  belongs_to :item
  belongs_to :meeting
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :item_id, presence: true
  validates :meeting_id, presence: true
  validates :meeting_id, :uniqueness=>{ :scope=> :item_id}

end
