# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  postal     :string(255)
#  geo        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#  updater_id :integer
#

class Site < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :geo, :name, :postal, :state 

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { maximum: 2 }
  validates :postal, presence: true, length: { maximum: 10 }
  validates :creator_id, presence: true
  validates :updater_id, presence: true

  has_many :rooms

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'


end
