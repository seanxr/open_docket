# == Schema Information
#
# Table name: memberships
#
#  id           :integer          not null, primary key
#  committee_id :integer
#  person_id    :integer
#  term_start   :date
#  term_end     :date
#  display_as   :string(255)
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  updater_id   :integer
#

require 'spec_helper'

describe Membership do
  pending "add some examples to (or delete) #{__FILE__}"
end
