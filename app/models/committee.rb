class Committee < ActiveRecord::Base
  attr_accessible :creator_id, :description, :name, :shortname, :updater_id

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'
end
