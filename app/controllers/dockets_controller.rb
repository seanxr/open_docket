class DocketsController < ApplicationController

  def new
   @committees = Committee.all
   @item = Item.find(params[:item_id])
   @committees_eligible = @item.notdocketcommittees
   @docket = Docket.new

  end


  def create
    @item = Item.find(params[:item_id])
    @docket = Docket.create(params[:docket])
    @docket.item_id = @item.id
    committee = @docket.committee

    if @docket.save
      flash[:success] = "You have successfully assigned item #{@item.number} to the #{committee.name} docket!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def destroy
    session[:return_to] = request.referer
    @item = Item.find(params[:item_id])    
    docket = @item.dockets.find_by_id(params[:id])
    committee = docket.committee
    docket.destroy
      flash[:success] = "You have successfully removed item #{@item.number} from the #{committee.name} docket"
#      redirect_to @item
    redirect_to session[:return_to]  
  end
end
