class AktionsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]
  before_filter :get_parent # Defined in ApplicationController

  def new
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @item = Item.find_by_id(params[:agendable_id])
    @action = Aktion.new

  end

  def create
    @item_meetings = params[:item_meetings_attributes]
    params[:aktion][:action_item_meetings_attributes] = params[:item_meetings_attributes].map{
       |x| {"item_meeting_id" => x, "creator_id" => current_user.id, "updater_id" => current_user.id}}
    @action = Aktion.new(params[:aktion])
    @action.creator_id = current_user.id
    @action.updater_id = current_user.id

    if @action.save_with_activity(current_user)
      flash[:success] = "You have succesfully created an action!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end

  def edit
    session[:return_to] = request.referer
    @action = Aktion.find(params[:id])
  end

  def update
    @action = Aktion.find(params[:id])
    @action.update_attributes(params[:aktion])
    @action.updater_id = current_user.id
    @item_meetings_pre_change = @action.item_meetings.collect { |item_meeting| item_meeting.id }
    @item_meetings_post_change = params[:item_meetings_attributes]
    @item_meetings_not_changing = @item_meetings_pre_change & @item_meetings_post_change 
    @item_meetings_destroy = @item_meetings_pre_change.reject { |x| @item_meetings_post_change.include? x }
    @item_meetings_add = @item_meetings_post_change.reject { |x| @item_meetings_pre_change.include? x }
    activity1 = Activity.create!(
        :message => "Updated action at #{@action.meeting.date} #{@action.meeting.committee_names_string} meeting. #{@action.discussion}",
        :activity_type => "UpdateAction", :date_actual => Date.today)
    ActivityLog.create(:activity_id => activity1.id, :owner_type => "Meeting", :owner_id => @action.meeting_id)
    if @item_meetings_not_changing.count > 0
      for item_meeting in @item_meetings_not_changing
        ActivityLog.create(:activity_id => activity1.id, :owner_type => item_meeting.agendable_type, :owner_id => item_meeting.agendable_id)
      end
    end
    if @item_meetings_destroy.count > 0
      for item_meeting in @item_meetings_destroy
        @action.item_meetings.find(item_meeting).action_item_meeting.destroy
        activity2 = Activity.create!(
          :message => "Removed action from #{ItemMeeting.find(item_meeting).agendable.name} for #{ItemMeeting.find(item_meeting).meeting.date} #{ItemMeeting.find(item_meeting).meeting.committee_names_string} meeting.",
          :activity_type => "RemoveActionFromItem", :date_actual => Date.today )
        ActivityLog.create(:activity_id => activity2.id, :owner_type => ItemMeeting.find(item_meeting).agendable_type, :owner_id => ItemMeeting.find(item_meeting).agendable_id)
        ActivityLog.create(:activity_id => activity2.id, :owner_type => "Meeting", :owner_id => ItemMeeting.find(item_meeting).meeting_id)
      end
    end
    if @item_meetings_add.count > 0
      for item_meeting in @item_meetings_add
        ActionItemMeeting.create(:aktion_id => @action.id, :item_meeting_id => item_meeting, :creator_id => current_user.id, :updater_id => current_user.id)
        activity3 = Activity.create!(
          :message => "Added action to #{ItemMeeting.find(item_meeting).agendable.name} for #{ItemMeeting.find(item_meeting).meeting.date} #{ItemMeeting.find(item_meeting).meeting.committee_names_string} meeting. #{@action.discussion}",
          :activity_type => "AddActionToItem", :date_actual => Date.today)
        ActivityLog.create(:activity_id => activity3.id, :owner_type => ItemMeeting.find(item_meeting).agendable_type, :owner_id => ItemMeeting.find(item_meeting).agendable_id)
        ActivityLog.create(:activity_id => activity3.id, :owner_type => "Meeting", :owner_id => ItemMeeting.find(item_meeting).meeting_id)
      end
    end
#     if (@item_meetings_pre_change.include? item.id) && (item_meetings_post_change.include? item.id)
#      ActivityLog.create!(:activity_id => activity1.id, :owner_type => "Meeting", :owner_id => meeting.id)
#        if !(@item_meetings_pre_change.include? item.id) && (item_meetings_post_change.include? item.id)
#        if (@item_meetings_pre_change.include? item.id) && !(item_meetings_post_change.include? item.id)
#    @item_meetings = params[:item_meetings_attributes]
#    params[:aktion][:action_item_meetings_attributes] = params[:item_meetings_attributes].map{
#       |x| {"item_meeting_id" => x, "creator_id" => current_user.id, "updater_id" => current_user.id}}
    if @action.update_attributes(params[:aktion])
      flash[:success] = "Action #{@item} successfully updated"
      redirect_to session[:return_to] 
    else
      render 'edit'
    end
  end


end
