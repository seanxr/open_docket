class DocumentsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]
  before_filter :admin_user,     only: [:new, :create, :edit, :update]
  before_filter :get_parent # Defined in ApplicationController

  def new
    if @parent.class.name == "Meeting"
      @items = @parent.items
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
      @items = @parent.items
    end
    @attachments = params[:item_attachments_attributes]
    @document.creator_id = current_user.id
    @document.updater_id = current_user.id

    if @document.save
      if @document.attachments.build(:owner_type => @parent.class.name, :owner_id => @parent.id).save
       if @attachments
          @attachments.each { |i| @document.attachments.build(:owner_type => "Item", :owner_id => i).save }
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
  end

end
