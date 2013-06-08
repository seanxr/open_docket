# == Schema Information
#
# Table name: committees
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  shortname   :string(255)
#  creator_id  :integer
#  updater_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Committee < ActiveRecord::Base
  attr_accessible :creator_id, :description, :name, :shortname, :updater_id, :item_id, :note

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :creator_id, presence: true

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  has_many :committee_meetings
  has_many :meetings, through: :committee_meetings

  has_many :dockets
  has_many :items, through: :dockets, source: :item

  has_many :activity_logs, :as => :owner
  has_many :activities, :through => :activity_logs, :as => :owner

  has_many :memberships
  has_many :people, through: :memberships, source: :person

  def ondocket?(item)
    dockets.find_by_item_id(item.id)
  end

  def ondocket!(item, note)
    dockets.create!(item_id: item.id, note: note)
    #create activities (on docket item and committee)
  end

  def undocket!(item)
    dockets.find_by_item_id(item.id).destroy
    #create activities (on docket item and committee)
  end

  def upcomingmeetings
    meetings.all.select { |v| v.date > Date.today}
  end

  def nextmeeting
    upcomingmeetings.sort_by do |d|
      d.date
    end
    upcomingmeetings.first
  end

  def memberships_current
    memberships.select{|x| x['term_end'] == nil}.sort_by{|e| e['position']}
  end

   def memberships_past
    memberships.select{|x| x['term_end'] != nil}
  end

   def members_names_string
    memberships_current.collect { |id| Membership.find_by_id(id).display_as }.join(', ') 
  end

  
end
