class AttachmentsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :destroy]
  before_filter :admin_user,     only: [:new, :destroy]


  def new
  end

  def destroy
    session[:return_to] = request.referer
    @document = Document.find(params[:document_id])    
    attachment = @document.attachments.find_by_id(params[:id])
    parent = attachment.owner
    attachment.destroy
      @activity1 = Activity.create(
                :message => "Document #{@document.name} removed from #{parent.class.name.downcase} #{parent.name}.",
                :activity_type => "DocumentFromParent", :date_actual => Date.today)
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Document", :owner_id => @document.id) 
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => parent.class.name, :owner_id => parent.id) 
      flash[:success] = "You have successfully removed document #{@document.name} from #{parent.class.name.downcase} #{parent.name}"
#      redirect_to @item
    redirect_to session[:return_to]  
  end

end
