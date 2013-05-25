# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_url  :text
#

class Person < ActiveRecord::Base
  attr_accessible :creator_id, :fname, :lname, :updater_id, :image_url

  has_many :activity_logs, :as => :owner
  has_many :activities, :through => :activity_logs, :as => :owner

  has_many :memberships
  has_many :committees, through: :memberships
  has_many :dockets_as_assigner,      :class_name => 'Docket',      :foreign_key => 'assigner_id'
  has_many :meetings_as_assigner,     :class_name => 'ItemMeeting',     :foreign_key => 'assigner_id'
  
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  def name
    self.fname + " " + self.lname
  end

  def memberships_current
    memberships.select{|x| x['term_end'] == nil}
  end

   def memberships_past
    memberships.select{|x| x['term_end'] != nil}
  end

  def save_with_activities(current_user)
    Person.transaction do
      self.save!
      activity1 = Activity.create!(
        :message => "#{name} added to OpenDocket by #{current_user.name}",
        :activity_type => "NewPerson", :date_actual => Date.today)
      ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Person", :owner_id => self.id) 
    end
  end

end
