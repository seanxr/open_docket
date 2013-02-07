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

class Document < ActiveRecord::Base
  attr_accessible :description, :doc_type, :name, :submitted_by, :submitted_on, :URL, :attachments_attributes

  has_many :attachments 
  has_many :owners, :through => :attachments

  accepts_nested_attributes_for :attachments 

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :URL, presence: true

end
