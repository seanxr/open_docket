class ItemMeetingsController < ApplicationController

  def new
   @item = Item.find(params[:item_id])
   @itemmeeting = ItemMeeting.new
   @potentialmeetings = @item.potentialmeetings

  end

  def create
    @item = Item.find(params[:item_id])
    @itemmeeting = ItemMeeting.create(params[:item_meeting])
    @itemmeeting.item_id = @item.id
    meeting = @itemmeeting.meeting
    @potentialmeetings = @item.potentialmeetings

    if @itemmeeting.save
      @activity1 = Activity.create(
                :message => "Item #{@item.name} assigned to #{meeting.name} meeting.",
                :activity_type => "ItemToMeeting", :date_actual => Date.today)
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Item", :owner_id => @item.id) 
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Meeting", :owner_id => meeting.id) 
      flash[:success] = "You have successfully assigned item #{@item.name} to the #{meeting.date} meeting!"
      redirect_to @item
    else
      render 'new'
    end
  end


end
