class ProductInvitationsController < ApplicationController
  before_filter :authenticate_company!, :only => [:index, :create, :show, :new]
  layout 'corporate'

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
  
  def view_invitation
    @product = Product.find(params[:id])
    @item = Item.new(:product_id => @product.id)
    session[:new_item] = params[:id]
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
      #@item.add_image_from_url @item.product.main_image
      @user = current_user 
      flash[:notice] = "Thanks for talking about your #{@item.product.name}"
      @user.items << @item
      @item.update_attribute(:invitation_status, 'complete')

      @invitation = Invitation.find(session[:invitation_id])
      @client = Client.find(session[:client_id])
      @sale = @invitation.sale_for @client

      if session[:signin_type] == 'facebook'
        @sale.update_attribute('logged_in_with_fb', true)
        redirect_to home_url+'#share_review'
      elsif session[:signin_type] == 'standard'
        @sale.update_attribute('logged_in_with_prizzm', true)
        redirect_to home_url
      end
      session[:signin_type] = nil
    else
      flash[:error] = "Can't determine which product you were invited to view"
      redirect_to home_url
    end
  end


  def share_review
    @item = Item.find(session[:accepted_item])
    render :layout => nil
  end

  def post_review_to_fb
    #@item = current_user.items.find(params[:item_id])
    # Using and clearing session to fix double posts..  HACK
    @item = current_user.items.find(session[:accepted_item])
    if @item
      @item.update_attribute(:privacy, 'public')
      session[:accepted_item] = nil

      if Rails.env.development?
        image_url = request.protocol + request.host_with_port + @item.product.main_image
      else
        image_url = @item.product.main_image
      end
      message = {:message => "#{@item.review}", :link => show_item_url(current_user, @item), :picture => image_url}
      Facebook.post_message(message, current_user.access_token) 

      @invitation = Invitation.find(session[:invitation_id])
      @client = Client.find(session[:client_id])
      @sale = @invitation.sale_for @client
      @sale.update_attribute('shared_item_to_fb', true)

    end
    redirect_to home_path
  end
end
