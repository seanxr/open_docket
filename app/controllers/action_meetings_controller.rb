class ActionMeetingsController < ApplicationController

  def reorder
     new_order = params[:action_meetings]
#     meeting = Meeting.find(params[:id])
#     flash[:success] = "#{params}"
    action_meetings = Meeting.find_by_id(params[:meeting]).action_meetings # get all action_meetings belonging to the current meeting
#     flash[:success] = "#{action_meetings}"
    update_order(new_order, action_meetings) # the update is in a separate method, so we can reuse it in other controllers
    render :text => nil # we have to render something, since it's a controller action
  end

  def destroy
    session[:return_to] = request.referer
    @action_meeting = ActionMeeting.find(params[:id])
    if @action_meeting.destroy_with_activities(current_user)
      flash[:success] = "You have successfully removed #{@action_meeting.reportable_name} from #{@action_meeting.meeting.committee_names_string} #{@action_meeting.meeting.name} meeting!"
      redirect_to session[:return_to]
    end
  end
end
