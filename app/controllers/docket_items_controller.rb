class DocketItemsController < ApplicationController

def create
    @docketitem = DocketItem.new(params[:docket_item])
    @docketitem.creator_id = current_user.id
    @docketitem.updater_id = current_user.id
    if @docketitem.save
      flash[:success] = "You have succesfully created a new docket item!"
      redirect_to @docketitem
    else
      render 'new'
    end
  end

  def edit
     @docketitem = DocketItem.find(params[:id])
  end

  def update
    @docketitem = DocketItem.find(params[:id])
    @docketitem.updater_id = current_user.id
    if @docketitem.update_attributes(params[:docket_item])
      flash[:success] = "Docket item updated"
      redirect_to @docketitem
    else
      render 'edit'
    end
  end

  def show
    @docketitem = DocketItem.find(params[:id])
  end

  def new
    @docketitem = DocketItem.new
  end

  def index
    @docketitems = DocketItem.all
  end
end
