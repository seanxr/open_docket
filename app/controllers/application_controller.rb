class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

 def get_parent

 # Determines the document parent for purposes of creating the attachment record

    if params[:item_id]
      @parent = Item.find(params[:item_id])
#      @template_prefix = 'items/documents/'
    elsif params[:meeting_id]
      @parent = Meeting.find(params[:meeting_id])
#      @template_prefix = 'events/documents/'
    else
      # Need better fail case
      @parent = 1
    end
  end

end
