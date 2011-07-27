class ItemsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout :determine_layout
  helper_method :new_privacy_message

  def new
    @item = Item.new
  end

  def create
    if params[:search]
      @item = Item.create(:name => params[:search])
    else
      @item = Item.create(params[:item])
    end
    current_user.items << @item
    if @item.possession_status == 'want'
      redirect_to owners_wanted_item_view_path(@item)
    elsif @item.possession_status == 'have'
      redirect_to owners_owned_item_view_path(@item)
    end
    ActivityLogger.user_create_item :user => current_user, :item => @item
  end

  def edit
    @item = current_user.find(params[:id])
  end

  def show
    @user = current_user
    @item = current_user.items.find(params[:id])
    #ActivityLogger.log_event("user.watch.item", {:user => current_user, :item => @item})
  end

  def update 
    @item = current_user.items.find(params[:id])
    if @item.update_attributes(params[:item])
      respond_to do |format|
        if @item.possession_status == 'have'
          format.html {redirect_to owners_owned_item_view_path}
        else
          format.html {redirect_to owners_wanted_item_view_path}
        end
        format.json {head :ok}
      end 
    end
    ActivityLogger.user_update_item :user => current_user, :item => @item
  end
  
  def destroy
    @item = current_user.items.find(params[:id])    
    @item.destroy
    respond_to do |format|
      format.json {render :json => @item.id}
    end 
    #ActivityLogger.log_event("user.delete.item", {:user => current_user, :item => @item})
    ActivityLogger.user_delete_item :user => current_user, :item => @item
  end

  def sort
    @user = current_user
    @item = Item.find(params[:id]) 
    @item.update_attribute(:possession_status,  params[:possession_status])
    #find_changed_item_ids
    #update_item_ordering
    head :ok
  end

  def update_review
    @item = current_user.items.find(params[:id])
    @item.update_attribute(:review, params[:review])
    render :json => @item.review
    ActivityLogger.user_review_item :user => current_user, :item => @item
  end 

  def update_item_name
    @item = current_user.items.find(params[:id])
    @item.update_attribute(:name, params[:name])
    render :json => @item.name
    ActivityLogger.user_name_item :user => current_user, :item => @item
  end

  def update_privacy
    @item = current_user.items.find(params[:id])
    old_privacy = @item.privacy
    @item.update_attribute(:privacy, new_item_privacy(@item.privacy))
    render :json => {:item_privacy  => @item.privacy,  :old_privacy => old_privacy }
    ActivityLogger.user_change_privacy_item :user => current_user, :item => @item
  end 

  def rate
    @item = current_user.items.find(params[:object_id])
    @item.update_attribute(:rating, params[:rating])
    ActivityLogger.user_rate_item  :user => current_user, :item => @item
    head :ok
  end

  def share
    user_id = params[:user_id]
    item_id = params[:item_id]

    @shared_fb = params[:item]['shared_facebook'].blank? ? false : true
    @shared_tt = params[:item]['shared_twitter'].blank? ? false : true
    item_show_page = request.url.chomp('/share')
    first_name = User.find_by_id(user_id).first_name
    item_name = Item.find_by_id(item_id).name

    message = "#{first_name} has just left an opinion on #{item_name} on Prizzm. #{item_show_page}"
    fb_message = {:message => "#{first_name} has just left an opinion on #{item_name} on Prizzm", :link => item_show_page}
    if @shared_tt
      TwitterConfig.update_config(current_user.tt_token, current_user.tt_secret)
      Twitter.update(message) 
    end
    Facebook.post_message(fb_message, current_user.access_token) if @shared_fb

    respond_to do |format|
      format.html { }
      format.js { render 'share' }
    end
    #ActivityLogger.log_event("user.share.item", {:user => current_user, :item => @item})
    ActivityLogger.user_share_item :user => current_user, :item => @item
  end


  private 
  # Apply a layout or not, based on the controller action:
  # If we are looking at a single item, use the normal application layout.
  # However for other AJAX actions, don't use any layout.
    def determine_layout
      ['show'].include?(action_name) ? 'application' : nil 
    end 



    def new_item_privacy privacy
      if privacy == "private"
        "public"
      else
        "private"
      end
    end 
  #
    def find_changed_item_ids
      old_item_order = extract_ids(params[:old_item_order])
      new_item_order = extract_ids(params[:new_item_order])
      @old_item_ids = []
      @new_item_ids = []
      new_item_order.each_with_index do |item, index| 
        (old_item_order[index] == item) ? nil : (@new_item_ids << item; @old_item_ids << old_item_order[index]) 
      end
    end

    def update_item_ordering
      old_items = @user.items.find @old_item_ids
      old_positions = old_items.map{|o| o.position }
      @new_item_ids.each_with_index do |item_id, index|
        item = @user.items.find(item_id)
        item.update_attribute(:position, old_positions[index])
      end 
    end
  
    def extract_ids items
      items.map{|item| item.delete('item_').to_i}
    end

end
