# == Schema Information
#
# Table name: memberships
#
#  id           :integer          not null, primary key
#  committee_id :integer
#  person_id    :integer
#  term_start   :date
#  term_end     :date
#  display_as   :string(255)
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  updater_id   :integer
#

class Membership < ActiveRecord::Base
  attr_accessible :committee_id, :display_as, :person_id, :position, :term_end, :term_start

  # term_start needs to be validated that it doesn't fall in-between any existing start/end pair
  # for the committee/person pair. Another way to think about it: committee/person pair has to be 
  # unique for all days in the range of days.
  # Also cannot have a term_start without term_end if there is an existing row for the committee/person 
  # pair without a term_end. In other words, only one term_start/no term_end per committee/person pair 
  validates :term_start, presence: true

  #  term_end needs to be validated that it is greater than term_start
  #  validates :term_end, 
  validates :committee_id, presence: true
  validates :person_id, presence: true
  validates :display_as, presence: true, length: { minimum: 5 }
  validates :creator_id, presence: true

  belongs_to :committee
  belongs_to :person

  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'

  # This formats term ends and adds "present" for term_end if there is no term_end date.

  def term_string
    if term_end
      term_start.strftime("%m/%d/%Y") + " - " + term_end.strftime("%m/%d/%Y")
    else
       term_start.strftime("%m/%d/%Y") + "- present"
    end
  end

  def save_with_activity
    Membership.transaction do
      activity = Activity.create!(
        :message => "#{person.name} added to #{committee.name} for the term: #{term_string}.",
        :activity_type => "PersonToCommittee", :date_actual => Date.today)

        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => person_id) 
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Committee", :owner_id => committee_id)
        self.save!
    end
  end

  def update_with_activity
    Membership.transaction do
      activity = Activity.create!(
        :message => "#{person.name} assignment to #{committee.name} edited. Term: #{term_string}.",
        :activity_type => "PersonToCommittee", :date_actual => Date.today)

        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Person", :owner_id => person_id) 
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Committee", :owner_id => committee_id)
        self.save!
    end
  end

end
