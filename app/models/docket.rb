# == Schema Information
#
# Table name: dockets
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  committee_id :integer
#  creator_id   :string(255)
#  integer      :string(255)
#  updater_id   :string(255)
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Docket < ActiveRecord::Base
  attr_accessible :committee_id, :creator_id, :item_id, :integer, :integer, :note, :updater_id

  belongs_to :committee
  belongs_to :item
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :committee_id, presence: true
  validates :item_id, presence: true
  validates :committee_id, :uniqueness=>{ :scope=> :item_id}
end
