# == Schema Information
#
# Table name: attendance_text
#
#  id         :integer          not null, primary key
#  text       :text
#  meeting_id :integer
#  creator_id :integer
#  updater_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AttendanceText < ActiveRecord::Base
  attr_accessible :creator_id, :meeting_id, :text, :updater_id

  has_one :meeting
  belongs_to :meeting

  belongs_to :creator,     :class_name => 'User'
  belongs_to :updater,     :class_name => 'User'

  validates :meeting_id, presence: true
  validates_uniqueness_of :meeting_id

  def save_with_activity 

    AttendanceText.transaction do
      self.save!
      activity = Activity.create!(
        :message => "Attendance text added to #{meeting.date.strftime("%m/%d/%y")} meeting.",
        :note => "#{text}",
        :activity_type => "NewAttendanceText", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => meeting.id)
    end
  end

  def name
    if text.length > 50
      "Attendance text: "+ text[0..50]+"..."
    else
      "Attendance text: "+ text
    end
  end

end
