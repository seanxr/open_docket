class MeetingsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]
#  before_filter :get_parent # Defined in ApplicationController

 def create
    @committees = Committee.all
    @rooms = Room.all
    if params[:has_committee]
     @committee = Committee.find(params[:has_committee])
    end
    if params[:committee_meetings_attributes]
      @committee_meetings = params[:committee_meetings_attributes]
    end
    @meeting = Meeting.new(params[:meeting])
    @meeting.creator_id = current_user.id
    @meeting.updater_id = current_user.id
#    @committee_name_string = for @committee_meetings.each { |i| Committee.find_by_id(i).name & "/" }
# Need to put an error if no committee.

    if @committee_meetings
      if @meeting.save
#        if @meeting.committee_meetings.build(:committee_id => (params[:committee_id])).save
#          if @attachments
             @committee_meetings.each { |i| @meeting.committee_meetings.build(:committee_id => i).save }
#          end
         if @committee
           flash[:success] = "You have succesfully created a #{@committee.name} meeting on #{@meeting.date} in #{@meeting.room.site.name}, #{@meeting.room.name}!"
           redirect_to @committee
         else
           flash[:success] = "You have succesfully created a meeting on #{@meeting.date} in #{@meeting.room.site.name}, #{@meeting.room.name}!"
    	   redirect_to root_url
         end
      else
        render 'new'
      end
    else
      flash[:error] = "Please select a committee"
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
    @committees = Committee.all
    if params[:committee_id]
      @committee = Committee.find(params[:committee_id])
    end
    @meeting = Meeting.new
    @documents = @meeting.documents
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
    @documents = @meeting.documents
    @parent = @meeting
  end

  def index
    @meetings = Meeting.all
  end
end
