# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  discussion :text
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Action do
  pending "add some examples to (or delete) #{__FILE__}"
end
