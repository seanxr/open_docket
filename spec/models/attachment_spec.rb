# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  document_id :integer
#  owner_id    :integer
#  owner_type  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
