# == Schema Information
#
# Table name: item_meetings
#
#  id             :integer          not null, primary key
#  item_id        :integer
#  meeting_id     :integer
#  creator_id     :integer
#  updater_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  agendable_id   :integer
#  agendable_type :string(255)
#  position       :integer
#

require 'spec_helper'

describe ItemMeeting do
  pending "add some examples to (or delete) #{__FILE__}"
end
