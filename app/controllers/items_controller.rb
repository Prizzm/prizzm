class ItemsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json, :js
  #layout :determine_layout
  #layout :determine_layout


  def new
    @item = Item.new
    @item.images.build
  end

  def create
    if params[:search]
      @item = Item.create(:name => params[:search])
    else
      @item = Item.create(params[:item])
    end
    current_user.items << @item
    redirect_to @item
  end

  def edit
    @item = current_user.find(params[:id])
  end

  def show
    #@item = current_user.items.find(params[:id])
    @item = Item.find(params[:id])

    if @item.user == current_user
      render "show_private_item"
    elsif @item.is_public?
      render "show_public_item"
    else
      # User is somehow trying to see someone else's private item
      redirect_to dashboard_url
    end
  end

  def update 
    @item = current_user.items.find(params[:id])
    if @item.update_attributes(params[:item])
      respond_to do |format|
        format.html {redirect_to @item}
        format.json {head :ok}
        format.js {head :ok}
      end 
    end
  end
  
  def destroy
    @item = current_user.items.find(params[:id])    
    @item.destroy
    respond_to do |format|
      format.json {render :json => @item.id}
    end 
  end

  def update_review
    @item = current_user.items.find(params[:id])
    @item.update_attribute(:review, params[:review])
    render :json => @item.review
  end 

  def update_item_name
    @item = current_user.items.find(params[:id])
    @item.update_attribute(:name, params[:name])
    render :json => @item.name
  end

  def update_company
    @item = current_user.items.find(params[:id])
    @company = Company.find(params[:company_id])
    @item.update_attribute(:company_id, params[:company_id])
  end

  def rate
    @item = current_user.items.find(params[:object_id])
    @item.update_attribute(:rating, params[:rating])
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
    ActivityLogger.user_share_item :from => current_user, :for => [@item], :data => [:message => fb_message]
  end

  private 
  # Apply a layout or not, based on the controller action:
  # If we are looking at a single item, use the normal application layout.
  # However for other AJAX actions, don't use any layout.
    def determine_layout
      ['show'].include?(action_name) ? 'application' : nil 
    end 

end
