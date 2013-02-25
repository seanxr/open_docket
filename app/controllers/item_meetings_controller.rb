class ItemMeetingsController < ApplicationController

  def new
    session[:return_to] = request.referer
   if params[:item_id]
     @agendable = Item.find(params[:item_id])
     @potential_meetings = @agendable.potential_meetings
   elsif params[:meeting_id]
     @meeting = Meeting.find(params[:meeting_id])
     @potential_items = @meeting.potential_items
   end
   @item_meeting = ItemMeeting.new
  end

  def create
    @item_meeting = ItemMeeting.new(params[:item_meeting])
#    @item_meeting.agendable_id = @agendable.id
#    @item_meeting.agendable_type = @agendable.class.name
    @item_meeting.creator_id = current_user.id
    @item_meeting.updater_id = current_user.id
#    @potential_meetings = @agendable.potential_meetings

    if @item_meeting.save
      @activity1 = Activity.create(
                :message => "Item #{@item_meeting.agendable.name} added to  #{@item_meeting.meeting.committee_names_string} #{@item_meeting.meeting.name} meeting.",
                :activity_type => "ItemToMeeting", :date_actual => Date.today)
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => @item_meeting.agendable.class.name, :owner_id => @item_meeting.agendable.id) 
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Meeting", :owner_id => @item_meeting.meeting.id) 
      flash[:success] = "You have successfully added item #{@item_meeting.agendable.name} to the #{@item_meeting.meeting.committee_names_string} #{@item_meeting.meeting.date} meeting!"
      redirect_to session[:return_to] 
#     redirect_to @agendable
    else
      render 'new'
    end
  end

  def reorder
     new_order = params[:item_meetings]
#     meeting = Meeting.find(params[:id])
#     flash[:success] = "#{params}"
    item_meetings = Meeting.find_by_id(params[:meeting]).item_meetings # get all item_meetings belonging to the current meeting
#     flash[:success] = "#{item_meetings}"
    update_order(new_order, item_meetings) # the update is in a separate method, so we can reuse it in other controllers
    render :text => nil # we have to render something, since it's a controller action
  end

  def destroy
    session[:return_to] = request.referer
    @item_meeting = ItemMeeting.find(params[:id])
    if @item_meeting.destroy_with_activities(current_user)
      flash[:success] = "You have successfully removed #{@item_meeting.agendable_name} from #{@item_meeting.meeting.committee_names_string} #{@item_meeting.meeting.name} meeting!"
      redirect_to session[:return_to]
    end
  end
end
