class ProductInvitationsController < ApplicationController
  def index
   @product = Product.find(params[:product_id])
   @invitations = @product.product_invitations
  end

  def create
    require 'digest/md5'
    @pinvite = Product.find(params[:product_id]).product_invitations.create(params[:product_invitation])
    secret = Digest::SHA1.hexdigest("prizzm")
    encryptor = ActiveSupport::MessageEncryptor.new(secret)
    @pinvite.encrypted_id = Digest::MD5.hexdigest(@pinvite.id.to_s)
    @pinvite.save!
    redirect_to product_product_invitations_path(Product.find(params[:product_id]))
  end
  def view_invitation
    @product = Product.find(params[:id])
    @item = Item.new(:product_id => @product.id)
    session[:new_item] = params[:id]
  end 
  def new
    @product = Product.find(params[:product_id])
    @product_invitation = ProductInvitation.new
    @mail_templates = @product.mail_templates
  end
  def refresh_mail_templates
    @product = Product.find(params[:product_id])
    @mail_templates = @product.mail_templates
    render :inline=> "<%= collection_select('product_invitation','mail_template_id',@mail_templates,:id,:name) %>"
  end
  def show
    @product_invitation = ProductInvitation.find(params[:id])
    @product = Product.find(params[:product_id])
    @url = request.host_with_port
    if Mailer.product_invite(@product,@product_invitation,@url).deliver
      @product_invitation.sent = "sent"
      @product_invitation.sent_on = Time.now
      if @product_invitation.save!
        render :text=>"Invitation sent"
      end
    else
      render :text=>"please try later"
    end
#    redirect_to product_product_invitations_path(@product)
  end
  
  def accept_invitation
    # Create an orphan item in the database
    @item = Item.create(params[:item].merge(:product_id => session[:new_item], :privacy => 'public', :invitation_status => "incomplete"))
    session[:accepted_item] = @item.id

    # Authorize user FB/Twitter
    redirect_to user_omniauth_authorize_path(:facebook)
  end 

  def process_accepted_product_invitation
    if session[:accepted_item]
      @item = Item.find(session[:accepted_item])
      session[:accepted_item] = nil
      @item.add_image_from_url @item.product.images.first.image.url
      @user = current_user 
      flash[:notice] = "Thanks for talking about your #{@item.product.name}"
      @user.items << @item
      @item.update_attribute(:invitation_status, 'complete')
      message = {:message => "#{@user.first_name} has just talked about the #{@item.product.name} on Prizzm.", :link => shared_item_url(@item), :picture => @item.product.images.first.image.url}
      Facebook.post_message(message, @user.access_token) 
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = "Can't determine which product you were invited to view"
      redirect_to home_url
    end
  end

end
