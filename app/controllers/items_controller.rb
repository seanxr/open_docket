class ItemsController < ApplicationController

  def create
    @item = Item.new(params[:item])
    @item.creator_id = current_user.id
    @item.updater_id = current_user.id
    if @item.save
      flash[:success] = "You have succesfully created a new docket item!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def edit
     @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.updater_id = current_user.id
    if @item.update_attributes(params[:item])
      flash[:success] = "Docket item #{@item.name} updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def show
    @item = Item.find(params[:id])
    @meetings = @item.meetings
    @documents = @item.documents
    @parent = @item
  end

  def new
    @item = Item.new
  end

  def index
    @search = Item.new(params[:item])
    @items = Item.by_name(@search.name)
  end
end
