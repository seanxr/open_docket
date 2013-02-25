class RoomsController < ApplicationController

  def new
    @site = Site.find(params[:site_id])
    @room = Room.new
  end

  def create
    # @committees = Committee.all
    @site = Site.find(params[:site_id])
    @room = Room.create(params[:room])
    @room.site_id = @site.id
    @room.creator_id = current_user.id
    @room.updater_id = current_user.id

    if @room.save
      flash[:success] = "You have successfully created room #{@room.name} for the #{@site.name} site!"
      redirect_to @site
    else
      render 'new'
    end
  end


  def edit
    @room = Room.find(params[:id])
    @site = @room.site
  end


  def update
    @room = Room.find(params[:id])
    @site = @room.site
    @room.updater_id = current_user.id
    if @room.update_attributes(params[:room])
      flash[:success] = "Room #{@room.name} for the #{@site.name} site successfully updated"
      redirect_to @site
    else
      render 'edit'
    end
  end

end
