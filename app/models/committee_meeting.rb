# == Schema Information
#
# Table name: committee_meetings
#
#  id           :integer          not null, primary key
#  meeting_id   :integer
#  committee_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CommitteeMeeting < ActiveRecord::Base
  attr_accessible :committee_id, :meeting_id

  validates :committee_id, presence: true
  validates :meeting_id, presence: true

  belongs_to :meeting
  belongs_to :committee

end
