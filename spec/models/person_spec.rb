# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_url  :text
#

require 'spec_helper'

describe Person do
  pending "add some examples to (or delete) #{__FILE__}"
end
