# == Schema Information
#
# Table name: documents
#
#  id           :integer          not null, primary key
#  doc_type     :string(255)
#  name         :string(255)
#  description  :string(255)
#  submitted_by :string(255)
#  creator_id   :integer
#  updater_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  URL          :string(255)
#  submitted_on :date
#

require 'spec_helper'

describe Document do
  pending "add some examples to (or delete) #{__FILE__}"
end
