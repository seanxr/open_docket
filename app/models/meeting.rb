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
#  public_hearing      :boolean
#  notice              :text
#


class Meeting < ActiveRecord::Base
  attr_accessible :creator_id, :date, :room_id, :updater_id, :committee_meetings_attributes, :time, :public_hearing, :notice

  default_scope :order => "date DESC"

  has_many :committee_meetings
  accepts_nested_attributes_for :committee_meetings, 
    :allow_destroy => true

  has_many :committees, :through => :committee_meetings

  has_many :attachments, :as => :owner
  has_many :documents, :through => :attachments, :as => :owner

  has_many :aktions

  has_many :statuses, :as => :statused
 
  has_many :item_meetings
  has_many :agendables, :through => :item_meetings

  has_many :action_meetings
  has_many :reportables, :through => :action_meetings

  has_many :action_item_meetings, :through => :item_meetings

  has_many :activity_logs, :as => :owner
  has_many :activities, :through => :activity_logs, :as => :owner

  belongs_to :room
  has_one :site, :through => :room
    
  has_one :attendance_text
  has_one :notice

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
   
  def name
    self.date.strftime("%m/%d/%y")
  end

  def self.upcoming
     all.select { |x| x['date'] >= Date.today }
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
     self.committee_names_string + " (" + self.date.strftime("%m/%d/%Y") + ")"
   end

   def members_names_string
     committees.collect { |id| Committee.find_by_id(id).members_names_string }.join(', ')
   end
 
  def potential_items
    potential_items = []
    for committee in self.committees 
      potential_items = potential_items + committee.items
    end
    potential_items
  end

  def item_item_meetings
    item_meetings.all(:conditions => ["agendable_type = 'Item'"])
  end

  def items
    item_item_meetings.collect { |x| Item.find_by_id(x.agendable_id) }
  end

  def items_with_actions
    item_meetings_for_actions = action_item_meetings.collect { |x| ItemMeeting.find_by_id(x.item_meeting_id) }
    item_meetings_for_actions.select { |x| x.agendable_type = "Item" }.collect { |i| Item.find_by_id(i.agendable_id) }
  end

  def items_without_actions
    items - items_with_actions
  end

  def agenda_texts
    meeting_texts.select { |x| x['kind']=="Agenda" }
  end

  def report_texts
    meeting_texts.select { |x| x['kind']=="Report" }
  end

  def agenda_submissions
    statuses.select { |x| x['code'] == 1 }
  end

  def report_submissions
    statuses.select { |x| x['code'] == 2 }
  end

  def public_hearing_item_meetings
    item_item_meetings.select { |x| x['public_hearing'] == true }.sort_by { |y| y.position }
  end


end
