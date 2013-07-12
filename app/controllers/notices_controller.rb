class NoticesController < ApplicationController
  def new
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @notice = Notice.new
  end

  def edit
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @notice = Notice.find(params[:id])
  end


  def create
    @notice = Notice.new(params[:notice])
    @notice.creator_id = current_user.id
    @notice.updater_id = current_user.id
    @notice.meeting_id = (params[:meeting_id])

    if @notice.save_with_activity(current_user)
      flash[:success] = "You have succesfully created public hearing notice publication information: #{@notice.name}!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end

  def update
    @notice = Notice.find_by_id(params[:id])
    @notice.updater_id = current_user.id

    if @notice.update_attributes(params[:notice])
      activity = Activity.create!(
        :message => "Public hearing notice publication information updated on #{@notice.meeting.date.strftime("%m/%d/%y")} meeting.",
        :note => "#{@notice.publication}",
        :activity_type => "UpdatedNotice", :date_actual => Date.today)
        ActivityLog.create!(:activity_id => activity.id, :owner_type => "Meeting", :owner_id => @notice.meeting.id)
      flash[:success] = "You have succesfully updated public hearing notice publication information: #{@notice.name}!"
      redirect_to session[:return_to] 
    else
      render 'edit'
    end
  end



end
