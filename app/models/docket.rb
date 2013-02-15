# == Schema Information
#
# Table name: dockets
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  committee_id :integer
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  updater_id   :integer
#

class Docket < ActiveRecord::Base
  attr_accessible :committee_id, :creator_id, :item_id, :integer, :integer, :note, :updater_id, :statuses_attributes, :activities_attributes

  belongs_to :committee
  belongs_to :item
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :committee_id, presence: true
  validates :item_id, presence: true
  validates :committee_id, :uniqueness=>{ :scope=> :item_id}
#  vaiidates :creator_id, presence: true

  has_many :statuses, :as => :statused
  accepts_nested_attributes_for :statuses
#  accepts_nested_attributes_for :activities

  def age
    (Date.today - self.statuses.last.as_of.to_date).to_i
  end

  def name
    self.id
  end

  def currentstatus
    self.statuses.last.code
  end 

end
