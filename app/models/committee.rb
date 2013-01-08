# == Schema Information
#
# Table name: committees
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  shortname   :string(255)
#  creator_id  :integer
#  updater_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Committee < ActiveRecord::Base
  attr_accessible :creator_id, :description, :name, :shortname, :updater_id

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'
end
