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

class Attachment < ActiveRecord::Base
  attr_accessible :document_id, :owner_id, :owner_type
  
  validates :document_id, presence: true
  validates :owner_id, presence: true
  validates :owner_type, presence: true
 
  belongs_to :document
  belongs_to :owner, :polymorphic => true

end
