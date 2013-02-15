class CommitteesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]

 def create
    @committee = Committee.new(params[:committee])
    @committee.creator_id = current_user.id
    @committee.updater_id = current_user.id

    if @committee.save
      flash[:success] = "You have succesfully created a new committee!"
      redirect_to @committee
    else
      render 'new'
    end
  end

  def edit
     @committee = Committee.find(params[:id])
  end

  def update
    @committee = Committee.find(params[:id])
    @committee.updater_id = current_user.id
    if @committee.update_attributes(params[:committee])
      flash[:success] = "Committee updated"
      redirect_to @committee
    else
      render 'edit'
    end
  end

  def show
    @committee = Committee.find(params[:id])
    @activities = @committee.activities
    if @committee.dockets.count > 0
      @dockets = @committee.dockets
      @agingaverage = @dockets.collect(&:age).inject(:+)/@dockets.size
    end
    @meetings = @committee.meetings
  end

  def new
    @committee = Committee.new
  end

  def index
    @committees = Committee.all
  end
end
