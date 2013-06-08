# == Schema Information
#
# Table name: meetings
#
#  id                  :integer          not null, primary key
#  date                :date
#  room_id             :integer
#  creator_id          :integer
#  updater_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  assigner_id         :integer
#  time                :time
#  attendance_text     :text
#  agenda_submitted_by :integer
#  agenda_submitted_on :date
#  report_submitted_by :integer
#  report_submitted_on :date
#


class Meeting < ActiveRecord::Base
  attr_accessible :creator_id, :date, :room_id, :updater_id, :committee_meetings_attributes, :time
  default_scope :order => "date DESC"

  has_many :committee_meetings
  accepts_nested_attributes_for :committee_meetings, 
    :allow_destroy => true

  has_many :committees, :through => :committee_meetings

  has_many :attachments, :as => :owner
  has_many :documents, :through => :attachments, :as => :owner

  has_many :aktions
 
  has_many :item_meetings
  has_many :agendables, :through => :item_meetings

  has_many :action_item_meetings, :through => :item_meetings

  has_many :activity_logs, :as => :owner
  has_many :activities, :through => :activity_logs, :as => :owner

  belongs_to :room
  has_one :site, :through => :room

  has_one :attendance_text

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
   
  def name
    self.date
  end
  
  def validate_committee
    if (self.committee_meetings.sum(:count) == 0)
      self.errors.add(:base, "A meeting must have a committee")
    end 
  end

   def committee_names_string
    committees.collect { |id| Committee.find_by_id(id).name }.join('/') 
  end

   def name_date_string
     self.committee_names_string + " (" + self.name.strftime("%m/%d/%Y") + ")"
   end

   def members_names_string
     committees.collect { |id| Committee.find_by_id(id).members_names_string }.join(', ')
   end
 
  def potential_items
    Item.all
  end
end
