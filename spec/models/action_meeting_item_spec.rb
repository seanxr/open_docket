# == Schema Information
#
# Table name: action_meeting_items
#
#  id              :integer          not null, primary key
#  action_id       :integer
#  meeting_item_id :integer
#  creator_id      :integer
#  updater_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe ActionMeetingItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
