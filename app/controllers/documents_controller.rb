class DocumentsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]
  before_filter :get_parent # Defined in ApplicationController

  def new
    if @parent.class.name == "Meeting"
      @item_meetings = @parent.item_meetings
    end
    @document = Document.new
    @document.submitted_on = Date.today
#    render :template => @template_prefix + 'new'
  end

  def create
  
    @document = Document.new(params[:document])
    if @document.name == ""
      @document.name = @document.URL
    end
    if @parent.class.name == "Meeting"
      @item_meetings = @parent.item_meetings
    end
    @attachments = params[:item_attachments_attributes]
    @document.creator_id = current_user.id
    @document.updater_id = current_user.id

    if @document.save
      @activity1 = Activity.create(
                :message => "Document #{@document.name} uploaded into Open Docket",
                :activity_type => "DocumentUploaded", :date_actual => Date.today)
      ActivityLog.create(:activity_id => @activity1.id, :owner_type => "Document", :owner_id => @document.id) 

      if @document.attachments.build(:owner_type => @parent.class.name, :owner_id => @parent.id).save
          @activity2 = Activity.create(
                :message => "Document #{@document.name} attached to #{@parent.class.name} #{@parent.name}.",
                :activity_type => "DocumentAttachment", :date_actual => Date.today)
          ActivityLog.create(:activity_id => @activity2.id, :owner_type => "Document", :owner_id => @document.id) 
          ActivityLog.create(:activity_id => @activity2.id, :owner_type => @parent.class.name, :owner_id => @parent.id)   

        if @attachments
          for attachment in @attachments.each do
            @document.attachments.build(:owner_type => "Item", :owner_id => attachment).save
            @activity3 = Activity.create(
                :message => "Document #{@document.name} attached to Item {Item.find_by_id(attachment).name}.",
                :activity_type => "DocumentAttachment", :date_actual => Date.today)
            ActivityLog.create(:activity_id => @activity3.id, :owner_type => "Document", :owner_id => @document.id) 
            ActivityLog.create(:activity_id => @activity3.id, :owner_type => "Item", :owner_id => attachment)              
          end
        end
        flash[:success] = "You have succesfully uploaded document #{@document.name} to #{@parent.class.name.downcase} #{@parent.name}"
        redirect_to @parent


      else
        @document.destroy
        render 'new'
      end

    else
      render 'new'
    end

  end

  def show
    @document = Document.find_by_id(params[:id])
    @attachedto = @document.attachments.collect
    @activities = @document.activities
  end

end
