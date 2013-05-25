class MembershipsController < ApplicationController
  before_filter :admin_user,     only: [:new, :create]

  def new
   session[:return_to] = request.referer
   if params[:person_id]
     @person = Person.find(params[:person_id])
     @committees = Committee.all
   end
   if params[:committee_id]
     @committee = Committee.find(params[:committee_id])
   end
     @membership = Membership.new
  end

  def create
    @person = Person.find(params[:person_id]) 
    @committee = Committee.find_by_id(params[:membership][:committee_id])
    @membership = Membership.new(params[:membership])
    @membership.person_id = @person.id
    @membership.creator_id = current_user.id
    @membership.updater_id = current_user.id

    if @membership.save_with_activity
      flash[:success] = "You have successfully assigned #{@person.name} to the #{@committee.name}!"
      redirect_to session[:return_to] 
    else
      render 'new'
    end
  end

  def edit
    session[:return_to] = request.referer
 # For now, going to assume edit to membership will not change person.
    @committees = Committee.all
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.updater_id = current_user.id
    @membership.assign_attributes(params[:membership])
    if @membership.update_with_activity
      flash[:success] = "Successfully updated #{@membership.person.name}'s assignment to #{@membership.committee.name}"
      redirect_to session[:return_to]
    else
      render 'edit'
    end
  end


end
