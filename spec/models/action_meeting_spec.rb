# == Schema Information
#
# Table name: action_meetings
#
#  id              :integer          not null, primary key
#  meeting_id      :integer
#  creator_id      :integer
#  updater_id      :integer
#  reportable_id   :integer
#  reportable_type :string(255)
#  position        :integer
#  assigner_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  aktion_id       :integer
#

require 'spec_helper'

describe ActionMeeting do
  pending "add some examples to (or delete) #{__FILE__}"
end
