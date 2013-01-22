# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :date
#  room_id    :integer
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meeting < ActiveRecord::Base
  attr_accessible :creator_id, :date, :room_id, :updater_id

  has_many :committee_meetings
  accepts_nested_attributes_for :committee_meetings, :allow_destroy => true
  attr_accessible :committee_meetings_attributes

  has_many :committees, through: :committee_meetings

  belongs_to :room
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
  

end
