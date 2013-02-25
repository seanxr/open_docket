class ItemsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]

  def create
    @item = Item.new(params[:item])
    @item.creator_id = current_user.id
    @item.updater_id = current_user.id
    @item.statuses_attributes = 
                [ {"creator_id" => @item.creator_id, "updater_id" => @item.updater_id, 
                 "code" => "1", "as_of" => params[:status][:as_of] } ]
    if @item.save_with_activities(current_user)
      flash[:success] = "You have succesfully created docket item #{@item.name}!"
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
    @status = @item.statuses.last.code
    @meetings = @item.meetings
    @documents = @item.documents
    @activities = @item.activities
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
