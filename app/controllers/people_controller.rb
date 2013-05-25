class PeopleController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    @person.creator_id = current_user.id
    @person.updater_id = current_user.id
 
    if @person.save_with_activities(current_user)
      flash[:success] = "You have succesfully added #{@person.name} to Open Docket!"
      redirect_to @person
    else
      render 'new'
    end
  end

  def show
    @person = Person.find(params[:id])
    @activities = @person.activities
    @memberships = @person.memberships
#    @committees = @person.committees
  end

  def index
    @people = Person.paginate(page: params[:page]).order('lname ASC')

  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    @person.updater_id = current_user.id
    if @person.update_attributes(params[:person])
      flash[:success] = "You have successfully updated #{@person.name}!"
      redirect_to @person
    else
      render 'edit'  
    end  
  end

end
