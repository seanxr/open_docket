# == Schema Information
#
# Table name: notices
#
#  id          :integer          not null, primary key
#  meeting_id  :integer
#  publication :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  updater_id  :integer
#  creator_id  :integer
#

class Notice < ActiveRecord::Base
  attr_accessible :creator_id, :meeting_id, :publication, :updater_id

  belongs_to :meeting
  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :meeting_id, presence: true
  validates_uniqueness_of :meeting_id

  def save_with_activity(current_user) 

    Notice.transaction do
      self.save!
      activity = Activity.create!(
        :message => "Public hearing notice publication information added to #{meeting.date.strftime("%m/%d/%y")} meeting.",
        :note => "#{publication}",
        :activity_type => "NewNotice", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id)
    end
  end

  def name
    if publication.length > 50
      publication[0..50]+"..."
    else
      publication
    end
  end
end
