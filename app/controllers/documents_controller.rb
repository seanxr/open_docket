class DocumentsController < ApplicationController


  def new
    @document = Document.new
    @owner_type = params[:owner_type]
    @owner_id = params[:owner_id]
    @item = Item.find(params[:item_id])
  end

  def create
    @document = Document.new(params[:document])
    @document.creator_id = current_user.id
    @document.updater_id = current_user.id
    @item = Item.find(params[:item_id])
    if @document.save
#      if @meeting.committee_meetings.build(:committee_id => (params[:committee_id])).save
      if @document.attachments.build(:owner_type => "Item", :owner_id => (params[:item_id])).save
#     if @document.attachments.build(:owner_type => (params[:object])).save
#      if @document.attachments.build(:owner_id => (params[:owner_id])).save
        flash[:success] = "You have succesfully uploaded document #{@document.name}!"
        redirect_to @item
      else
        @document.destroy
        render 'new'
      end
    else
      render 'new'
    end
  end
end
