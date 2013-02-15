# == Schema Information
#
# Table name: statuses
#
#  id            :integer          not null, primary key
#  code          :integer
#  statused_type :string(255)
#  statused_id   :integer
#  statuser_id   :integer
#  creator_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  as_of         :date
#  updater_id    :integer
#

class Status < ActiveRecord::Base
  attr_accessible :code, :creator_id, :updater_id, :statuser_id, :statused_id, :statused_type, :as_of

  belongs_to :statused, :polymorphic => true

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
  belongs_to :statuser,    :class_name => 'User'

  validates :as_of, presence: 'true'

end
