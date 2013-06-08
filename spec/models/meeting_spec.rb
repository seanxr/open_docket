# == Schema Information
#
# Table name: meetings
#
#  id                  :integer          not null, primary key
#  date                :date
#  room_id             :integer
#  creator_id          :integer
#  updater_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  assigner_id         :integer
#  time                :time
#  attendance_text     :text
#  agenda_submitted_by :integer
#  agenda_submitted_on :date
#  report_submitted_by :integer
#  report_submitted_on :date
#

require 'spec_helper'

describe Meeting do
  pending "add some examples to (or delete) #{__FILE__}"
end
