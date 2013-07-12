# == Schema Information
#
# Table name: public_hearings
#
#  id          :integer          not null, primary key
#  meeting_id  :integer
#  publication :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe PublicHearing do
  pending "add some examples to (or delete) #{__FILE__}"
end
