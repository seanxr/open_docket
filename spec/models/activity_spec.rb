# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  date_actual   :date
#  person_actual :string(255)
#  note          :text
#  activity_type :string(255)
#  creator_id    :integer
#  updater_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  message       :text
#

require 'spec_helper'

describe Activity do
  pending "add some examples to (or delete) #{__FILE__}"
end
