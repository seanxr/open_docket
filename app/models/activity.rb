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

class Activity < ActiveRecord::Base
  attr_accessible :date_actual, :note, :person_actual, :activity_type, :message

  has_many :activity_logs
  has_many :owners, :through => :activity_logs

  accepts_nested_attributes_for :activity_logs 

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  default_scope order('date_actual DESC, created_at DESC')    

end
