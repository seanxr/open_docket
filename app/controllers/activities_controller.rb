class ActivitiesController < ApplicationController

  def new
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @activity = Activity.new
  end

  def edit
    session[:return_to] = request.referer
    @meeting = Meeting.find(params[:meeting_id])
    @activity = Activity.find(params[:id])
  end


  def create
    @activity = Activity.new(params[:activity])
    @activity.creator_id = current_user.id
    @activity.updater_id = current_user.id
    @activity.item_id = (params[:item_id])

    if @activity.save
      flash[:success] = "You have succesfully created activity : #{@activity.name}!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end

  def update
    @activity = Activity.find_by_id(params[:id])
    @activity.updater_id = current_user.id

    if @activity.update_attributes(params[:activity])
      flash[:success] = "You have succesfully updated activity: #{@activity.name}!"
      redirect_to session[:return_to] 
    else
      render 'edit'
    end
  end
end
