# == Schema Information
#
# Table name: dockets
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  committee_id :integer
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  updater_id   :integer
#  as_of        :date
#  assigner_id  :integer
#

class Docket < ActiveRecord::Base
  attr_accessible :as_of, :committee_id, :creator_id, :item_id, :assigner_id,
      :note, :updater_id, :statuses_attributes, :activities_attributes

  belongs_to :committee
  belongs_to :item
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'
  belongs_to :assigner,    :class_name => 'Person'

  validates :committee_id, presence: true
  validates :item_id, presence: true
  validates :committee_id, :uniqueness=>{ :scope=> :item_id}
  #  vaiidates :creator_id, presence: true

  has_many :statuses, :as => :statused
  accepts_nested_attributes_for :statuses
  #  accepts_nested_attributes_for :activities

  def age
    (Date.today - statuses.last.as_of.to_date).to_i
  end

  def name
    id
  end

  def currentstatus
    statuses.last.code
  end 

  def save_with_activity
    Docket.transaction do
      activity1 = Activity.create!(
        :message => "Item #{item.name} added to #{committee.name} docket by #{assigner.name}. #{note}",
        :activity_type => "ItemToDocket", :date_actual => as_of)

        ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Item", :owner_id => item_id) 
        ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Committee", :owner_id => committee_id)
        self.save!
    end
  end
end
