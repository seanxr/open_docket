# == Schema Information
#
# Table name: attendance_texts
#
#  id         :integer          not null, primary key
#  text       :text
#  meeting_id :integer
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe AttendanceTexts do
  pending "add some examples to (or delete) #{__FILE__}"
end
