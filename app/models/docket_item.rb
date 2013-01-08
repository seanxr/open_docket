# == Schema Information
#
# Table name: docket_items
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
#

class DocketItem < ActiveRecord::Base
  attr_accessible :address, :draft, :number, :opened_on, :precinct, :request, :requested_by, :updater_id, :creator_id, :ward, :reference

  validates :number, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true
  validates :updater_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

end
