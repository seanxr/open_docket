class MeetingsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]

  def create
    @committees = Committee.all
    @sites = Site.all
    @committee_meetings = params[:committee_meetings_attributes]
    params[:meeting][:committee_meetings_attributes] = params[:committee_meetings_attributes].map{ |x| {"committee_id" => x}}
    @meeting = Meeting.new(params[:meeting])
    @meeting.creator_id = current_user.id
    @meeting.updater_id = current_user.id
    @committee_names_string =  params[:committee_meetings_attributes].collect { |id| Committee.find_by_id(id).name }.join('/') 
# Need to put an error if no committee selected.

    if @committee_meetings
      if @meeting.save
        @activity = Activity.create(
                :message => "Created new #{@committee_names_string} meeting for #{@meeting.date.strftime("%m/%d/%y") }.",
                :activity_type => "NewMeeting", :date_actual => @meeting.created_at)
        ActivityLog.create(:activity_id => @activity.id, :owner_type => "Meeting", :owner_id => @meeting.id)
        @committee_meetings.each { |i| ActivityLog.create(:activity_id => @activity.id, :owner_type => "Committee", :owner_id => i) }
        flash[:success] = "You have succesfully created a #{@committee_names_string} meeting on #{@meeting.date.strftime("%m/%d/%y") } in #{@meeting.room.site.name}, #{@meeting.room.name}!"
        redirect_to session[:return_to] 
      else
        render 'new'
      end
    else
#      flash[:error] = "Please select a committee"
      render 'new'
    end
  end

 def edit
    @meeting = Meeting.find(params[:id])
    @sites = Site.all
    @committees = Committee.all
    @documents = @meeting.documents
  end


  def update
    @meeting = Meeting.find(params[:id])
    @meeting.updater_id = current_user.id
    @committees_to_start = @meeting.committee_meetings.map{ |x| x.committee_id }
    @committee_meetings = params[:committee_meetings_attributes]
    if @committee_meetings
      @committees_to_remove = @committees_to_start - @committee_meetings
      @committees_to_stay = @committees_to_start & @committee_meetings
      @committees_to_add = @committee_meetings - @committees_to_start
      params[:meeting][:committee_meetings_attributes] = @committees_to_add.map{ |x| {"committee_id" => x}}
      @committees_to_remove.any? do 
        @committees_to_remove.each{ |i| @meeting.committee_meetings.find_by_committee_id(i).destroy 
        @activity = Activity.create(
                :message => "Removed #{Committee.find_by_id(i).name} from #{@meeting.date.strftime("%m/%d/%y") } meeting.",
                :activity_type => "RemoveCommitteeFromMeeting", :date_actual => Date.today )
        ActivityLog.create(:activity_id => @activity.id, :owner_type => "Meeting", :owner_id => @meeting.id)
        ActivityLog.create(:activity_id => @activity.id, :owner_type => "Committee", :owner_id => i) }
     end
      if @meeting.update_attributes(params[:meeting])
        @committees_to_add.any? do
           @committees_to_add.each{ |i|
               @activity = Activity.create(
                      :message => "Added #{Committee.find_by_id(i).name} to #{@meeting.date.strftime("%m/%d/%y") } meeting.",
                      :activity_type => "RemoveCommitteeFromMeeting", :date_actual => Date.today )
               ActivityLog.create(:activity_id => @activity.id, :owner_type => "Meeting", :owner_id => @meeting.id)
               ActivityLog.create(:activity_id => @activity.id, :owner_type => "Committee", :owner_id => i) }
        end
        flash[:success] = "You have successfully updated the #{@meeting.name_date_string} meeting!"
        redirect_to @meeting
      else
        render 'edit'
      end
    else
      render 'update'
    end
  end


  def new
    session[:return_to] = request.referer
    @sites = Site.all
    @committees = Committee.all
    if params[:committee_id]
      @committee = Committee.find(params[:committee_id])
    end
    @meeting = Meeting.new
    @documents = @meeting.documents
  end

  def show
    @meeting = Meeting.find(params[:id])
    @item_meetings = @meeting.item_meetings.order('position ASC')
    @action_meetings = @meeting.action_meetings.order('position ASC')
    @documents = @meeting.documents
    @parent = @meeting
    @activities = @meeting.activities
  end

  def index
    @meetings = Meeting.all
  end

  def agenda
    @meeting = Meeting.find(params[:id])
    @parent = "agenda"
    render :layout => false
  end

  def report
    @meeting = Meeting.find(params[:id])
    @parent = "report"
    render :layout => false
  end

end
