# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  floor      :string(255)
#  number     :string(255)
#  capacity   :integer
#  notes      :string(255)
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer
#


# Need to remove column number

class Room < ActiveRecord::Base
  attr_accessible :capacity, :creator_id, :floor, :name, :notes, :updater_id

  validates :name, presence: true, length: { maximum: 50 }
  validates :creator_id, presence: true
  validates :updater_id, presence: true
  validates :site_id, presence: true

  belongs_to :site
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  default_scope order: 'rooms.name ASC'
end
