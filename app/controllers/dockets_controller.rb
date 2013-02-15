class DocketsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]
  before_filter :admin_user,     only: [:new, :create, :destroy]

  def new
   @committees = Committee.all
   @item = Item.find(params[:item_id])
   @committees_eligible = @item.notdocketcommittees
   @docket = Docket.new

  end


  def create
    @item = Item.find(params[:item_id]) 
    @docket = Docket.new(params[:docket])
    @committees_eligible = @item.notdocketcommittees
    @committee = @docket.committee
    @docket.creator_id = current_user.id
    @docket.updater_id = current_user.id
    @docket.statuses_attributes = 
                [ {"creator_id" => @docket.creator_id, "updater_id" => @docket.updater_id, "code" => "1",
                "statuser_id" => "99", "as_of" => params[:status][:as_of] } ]
    @docket.item_id = @item.id
    @docket.save

    if @docket.save
      @activity1 = Activity.create(
                :message => "Item #{@item.name} added to #{@committee.name} docket. #{@docket.note}",
                :activity_type => "ItemToDocket", :date_actual => params[:status][:as_of])
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Item", :owner_id => @item.id) 
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Committee", :owner_id => @committee.id) 
      flash[:success] = "You have successfully assigned item #{@item.name} to the #{@committee.name} docket!"
      redirect_to @item
    else
      render 'new'
    end
  end


  def destroy
# This method is a hack. It needs to be in status controller.

    session[:return_to] = request.referer
    @item = Item.find(params[:item_id])    
    @docket = @item.dockets.find_by_id(params[:id])
    @committee = @docket.committee
     @docket.statuses.build(:statused_type => "Docket", :statused_id => @docket.id, :code => 2).save
#     docket.destroy
      @activity1 = Activity.create(
                :message => "Item #{@item.name} removed from #{@committee.name} docket.",
                :activity_type => "ItemToDocket", :date_actual => Date.today)
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Item", :owner_id => @item.id) 
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Committee", :owner_id => @committee.id)
      flash[:success] = "You have successfully removed item #{@item.name} from the #{@committee.name} docket"
#      redirect_to @item
    redirect_to session[:return_to]  
  end
end
