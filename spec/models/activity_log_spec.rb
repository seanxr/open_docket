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

require 'spec_helper'

describe ActivityLog do
  pending "add some examples to (or delete) #{__FILE__}"
end
