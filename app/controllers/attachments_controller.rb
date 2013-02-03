class AttachmentsController < ApplicationController
  def new
  end

  def destroy
    session[:return_to] = request.referer
    @document = Document.find(params[:document_id])    
    attachment = @document.attachments.find_by_id(params[:id])
    parent = attachment.owner
    attachment.destroy
      flash[:success] = "You have successfully removed document #{@document.name} from #{parent.class.name.downcase} #{parent.name}"
#      redirect_to @item
    redirect_to session[:return_to]  
  end

end
