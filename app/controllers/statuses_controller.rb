class StatusesController < ApplicationController
  def new
    session[:return_to] = request.referer  
    if params[:item_id]
      @parent = Item.find(params[:item_id])
    end
    if params[:docket_id]
      @parent = Docket.find(params[:docket_id])
    end
   @status = Status.new
   if @parent.statuses.last.code == 0
     @newcode = 1
   else
     @newcode = 0
   end
  end

  def create 
    @status = Status.new(params[:status])
    @status.creator_id = current_user.id
    @status.updater_id = current_user.id
    if params[:item_id]
      @parent = Item.find(params[:item_id])
    end
    if params[:docket_id]
      @parent = Docket.find(params[:docket_id])
    end
    @status.statused_type = @parent.class.name
    @status.statused_id = @parent.id    
      if @status.save
        if params[:docket_id]
          if @status.code = 1
            @activity1 = Activity.create(
                  :message => "Item #{@parent.item.name} added to #{@parent.committee.name} docket.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully added item #{@parent.item.name} to the #{@parent.committee.name} docket."
          else
            @activity1 = Activity.create(
                  :message => "Item #{@parent.item.name} removed from #{@parent.committee.name} docket.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully removed item #{@parent.item.name} from the #{@parent.committee.name} docket."
          end
          ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Committee", :owner_id => @parent.committee.id)
          ActivityLog.create(:activity_id => @activity1.id, :owner_type => @parent.class.name, :owner_id => @parent.id) 
        elsif
          if @status.code = 1
            @activity1 = Activity.create(
                  :message => "Item #{@parent.name} re-opened.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully re-opened item #{@parent.name}."
          else
            @activity1 = Activity.create(
                  :message => "Item #{@parent.name} closed.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully closed item #{@parent.name}."
          end
        ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Item", :owner_id => @parent.id)
        else
          @activity1 = Activity.create(
                :message => "#{@parent.class.name} #{@parent.name} status changed to #{@status.code}.", :note => params[:activity][:note],
                :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
          flash[:success] = "You have successfully changed the status of item #{@parent.name}."   
        end 
        redirect_to session[:return_to]    
      else
        render 'new'
      end
  end
end
