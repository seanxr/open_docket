class MeetingsController < ApplicationController

 def create
    @rooms = Room.all
    @committee = Committee.find(params[:committee_id])
#    @committees = Committee.all
    @meeting = Meeting.new(params[:meeting])
    @meeting.creator_id = current_user.id
    @meeting.updater_id = current_user.id
#    @meeting.committee_meetings.build  
#    @meeting.new(:committee_meeting_attributes => {:committee_id => @committee.id})  
#   @meeting.committee_meetings.build(:committee_id => (params[:committee_id])).save

      if @meeting.save
        if @meeting.committee_meetings.build(:committee_id => (params[:committee_id])).save
          flash[:success] = "You have succesfully created a #{@committee.name} meeting on #{@meeting.date} in #{@meeting.room.site.name}, #{@meeting.room.name}!"
          redirect_to @committee
        else
         @meeting.destroy
         render 'new'
        end
      else
        render 'new'
      end
  end

 def edit
     @meeting = Meeting.find(params[:id])
  end


  def update
    @meeting = Meeting.find(params[:id])
    @meeting.updater_id = current_user.id
    if @meeting.update_attributes(params[:meeting])
      flash[:success] = "You have successfully updated the #{@meeting.date} meeting!"
      redirect_to home
    else
      render 'edit'
    end
  end


  def new
    @rooms = Room.all
#    @committees = Committee.all
    @committee = Committee.find(params[:committee_id])
    @meeting = Meeting.new
#    @meeting.committee_meetings.build
#    Committee.all.each do |committee|
#      committee_meetings = @meeting.committee_meetings.build(:committee_id => committee.id)
#    end 

  end

  def show
    @meeting = Meeting.find(params[:id])
    @room = @meeting.room
    @site = @meeting.room.site
    @committees = @meeting.committees
    @itemmeetings = @meeting.item_meetings
  end

  def index
    @meetings = Meeting.all
  end
end
