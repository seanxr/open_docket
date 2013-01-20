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

require 'spec_helper'

describe CommitteeMeeting do
  pending "add some examples to (or delete) #{__FILE__}"
end
