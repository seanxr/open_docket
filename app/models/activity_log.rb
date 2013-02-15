# == Schema Information
#
# Table name: activity_logs
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  owner_type  :string(255)
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ActivityLog < ActiveRecord::Base
  attr_accessible :activity_id, :owner_id, :owner_type

  validates :activity_id, presence: true
  validates :owner_id, presence: true
  validates :owner_type, presence: true


  belongs_to :activity
  belongs_to :owner, :polymorphic => true

end
