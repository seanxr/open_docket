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

    if @itemmeeting.save
      flash[:success] = "You have successfully assigned item #{@item.number} to the #{meeting.date} meeting!"
      redirect_to @item
    else
      render 'new'
    end
  end


end
