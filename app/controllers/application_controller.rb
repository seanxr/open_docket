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

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

    # Updates items with new order number
  def update_order(new_order, items_to_update)
    if items_to_update != nil && new_order != nil && items_to_update.count == new_order.count
      items_to_update.each do |item|
        item.position = new_order.index(item.id.to_s) + 1
        item.save
      end
    end
  end


end
