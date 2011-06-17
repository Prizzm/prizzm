class ProductInvitationsController < ApplicationController


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
      @user = current_user 
      flash[:notice] = "Thanks for talking about your #{@item.product.name}"
      @user.items << @item
      @item.update_attribute(:invitation_status, 'complete')
      message = {:message => "#{@user.first_name} has just talked about the #{@item.product.name} on Prizzm.", :link => shared_item_url(@item), :picture => @item.product.images.first.image.url}
      puts message
      Facebook.post_message(message, @user.access_token) 
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = "Can't determine which product you were invited to view"
      redirect_to home_url
    end
  end 
end
