class MeetingTextsController < ApplicationController
  def new
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @meeting_text = MeetingText.new

  end

  def create
#    params[:meeting_text][:item_meeting_attributes] = [{"agendable_type" => "MeetingText", "agendable_id" => params[:meeting_id]}]
    @meeting_text = MeetingText.new(params[:meeting_text])
    @meeting_text.creator_id = current_user.id
    @meeting_text.updater_id = current_user.id

    if @meeting_text.save_with_activity
      flash[:success] = "You have succesfully created #{@meeting_text.name}!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end
end
