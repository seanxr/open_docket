class AttendanceTextsController < ApplicationController

  def new
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @attendance_text = AttendanceText.new

  end

  def edit
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @attendance_text = AttendanceText.find(params[:id])
  end


  def create
    @attendance_text = AttendanceText.new(params[:attendance_text])
    @attendance_text.creator_id = current_user.id
    @attendance_text.updater_id = current_user.id

    if @attendance_text.save_with_activity
      flash[:success] = "You have succesfully created attendance text: #{@attendance_text.text[0..100]}!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end

  def update
    @attendance_text = AttendanceText.find_by_id(params[:id])
    @attendance_text.updater_id = current_user.id

    if @attendance_text.update_attributes(params[:attendance_text])
      activity = Activity.create!(
        :message => "Attendance text updated on #{@attendance_text.meeting.date.strftime("%m/%d/%y")} meeting.",
        :note => "#{@attendance_text.text}",
        :activity_type => "NewAttendanceText", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => @attendance_text.meeting.id)
      flash[:success] = "You have succesfully updated attendance text: #{@attendance_text.text[0..100]}!"
      redirect_to session[:return_to] 
    else
      render 'edit'
    end
  end

end
