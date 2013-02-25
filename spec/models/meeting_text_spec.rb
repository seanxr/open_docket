# == Schema Information
#
# Table name: meeting_texts
#
#  id              :integer          not null, primary key
#  meeting_id      :integer
#  meeting_text    :text
#  action_required :integer
#  creator_id      :integer
#  updater_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe MeetingText do
  pending "add some examples to (or delete) #{__FILE__}"
end
