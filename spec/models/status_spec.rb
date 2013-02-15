# == Schema Information
#
# Table name: statuses
#
#  id            :integer          not null, primary key
#  code          :integer
#  statused_type :string(255)
#  statused_id   :integer
#  statuser_id   :integer
#  creator_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  as_of         :date
#  updater_id    :integer
#

require 'spec_helper'

describe Status do
  pending "add some examples to (or delete) #{__FILE__}"
end
