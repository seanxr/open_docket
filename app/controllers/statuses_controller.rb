class StatusesController < ApplicationController
  def new
    session[:return_to] = request.referer  
    if params[:item_id]
      @parent = Item.find(params[:item_id])
    elsif params[:docket_id]
      @parent = Docket.find(params[:docket_id])
    elsif params[:meeting_id]
      @parent = Meeting.find(params[:meeting_id])
    end
   @status = Status.new
   @new_code = params[:new_code]
   if params[:kind]
     @kind = params[:kind]
   end
  end

  def create 
    @status = Status.new(params[:status])
    @status.creator_id = current_user.id
    @status.updater_id = current_user.id
    if params[:item_id]
      @parent = Item.find(params[:item_id])
    elsif params[:docket_id]
      @parent = Docket.find(params[:docket_id])
    elsif params[:meeting_id]
      @parent = Meeting.find(params[:meeting_id])
    end
    @status.statused_type = @parent.class.name
    @status.statused_id = @parent.id    
      if @status.save
        if params[:docket_id]
          if @status.code == 1
            @activity = Activity.create(
                  :message => "Item #{@parent.item.name} added to #{@parent.committee.name} docket.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully added item #{@parent.item.name} to the #{@parent.committee.name} docket."
          else
            @activity = Activity.create(
                  :message => "Item #{@parent.item.name} removed from #{@parent.committee.name} docket.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully removed item #{@parent.item.name} from the #{@parent.committee.name} docket."
          end
          ActivityLog.create(:activity_id => @activity.id, :owner_type => "Committee", :owner_id => @parent.committee.id)
          ActivityLog.create(:activity_id => @activity.id, :owner_type => @parent.class.name, :owner_id => @parent.id) 
        elsif params[:item_id]
          if @status.code == 1
            @activity = Activity.create(
                  :message => "Item #{@parent.name} re-opened.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully re-opened item #{@parent.name}."
          else
            @activity = Activity.create(
                  :message => "Item #{@parent.name} closed.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}StatusTo#{@status.id}", :date_actual => @status.as_of)
            flash[:success] = "You have successfully closed item #{@parent.name}."
          end
        elsif params[:meeting_id]
          if @status.code == 0
            @activity = Activity.create(
                  :message => "Agenda for #{@parent.name} submitted by #{Person.find(@status.statuser_id).name}.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}AgendaSubmitted", :date_actual => @status.as_of)
            flash[:success] = "You have successfully submitted the agenda for #{@parent.name}."
          else
            @activity = Activity.create(
                  :message => "Report for #{@parent.name} submitted by #{Person.find(@status.statuser_id).name}.",
                  :note => params[:activity][:note],
                  :activity_type => "#{@parent.class.name}ReportSubmitted", :date_actual => @status.as_of)
            flash[:success] = "You have successfully submitted the report for #{@parent.name}."
          end
        ActivityLog.create(:activity_id => @activity.id, :owner_type => "Meeting", :owner_id => @parent.id)
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
