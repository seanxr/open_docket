class SitesController < ApplicationController

 def create
    @site = Site.new(params[:site])
    @site.creator_id = current_user.id
    @site.updater_id = current_user.id

    if @site.save
      flash[:success] = "You have succesfully created the #{@site.name} site!"
      redirect_to @site
    else
      render 'new'
    end
  end

 def edit
     @site = Site.find(params[:id])
  end


  def update
    @site = Site.find(params[:id])
    @site.updater_id = current_user.id
    if @site.update_attributes(params[:site])
      flash[:success] = "You have successfully updated the #{@site.name} site!"
      redirect_to @site
    else
      render 'edit'
    end
  end


  def new
    @site = Site.new
  end

  def show
    @site = Site.find(params[:id])
  end

  def index
    @sites = Site.all
  end

end
