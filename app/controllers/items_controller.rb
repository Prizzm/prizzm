class ItemsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout :determine_layout
  helper_method :new_privacy_message


  def create
    @item = Item.create(:name => params[:search])
    current_user.items << @item
    redirect_to owners_wanted_item_view_path(@item)
  end

  def edit
    @item = current_user.find(params[:id])
  end

  def show
    @user = current_user
    @item = current_user.items.find(params[:id])
  end

  update! do |success, failure| 
    success.html {redirect_to root_path}
    success.json {head :ok}
  end
  
  def destroy
    @item = current_user.items.find(params[:id])    
    @item.destroy
    respond_to do |format|
      format.json {render :json => params[:id]}
    end 
  end

  def sort
    @user = current_user
    @item = Item.find(params[:id]) 
    @item.update_attribute(:possession_status,  params[:possession_status])
    #find_changed_item_ids
    #update_item_ordering
    head :ok
  end

  def update_privacy
    @item = current_user.items.find(params[:id])
    old_privacy = @item.privacy
    @item.update_attribute(:privacy, new_item_privacy(@item.privacy))
    render :json => {:item_privacy  => @item.privacy,  :old_privacy => old_privacy }
  end 

  def rate
    current_user.items.find(params[:object_id]).update_attribute(:rating, params[:rating])
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
