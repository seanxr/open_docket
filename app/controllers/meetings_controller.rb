class MeetingsController < ApplicationController

 def create
    @rooms = Room.all
    @committees = Committee.all
    @meeting = Meeting.new(params[:meeting])
    @meeting.creator_id = current_user.id
    @meeting.updater_id = current_user.id

      if @meeting.save
        flash[:success] = "You have succesfully created a meeting on #{@meeting.date} in #{@meeting.room.site.name}, #{@meeting.room.name}!"
        redirect_to root_url 
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
    @meeting = Meeting.new
#    @meeting.committee_meetings.build
    Committee.all.each do |committee|
      committee_meetings = @meeting.committee_meetings.build(:committee_id => committee.id)
    end 

  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def index
    @meetings = Meeting.all
  end
end
