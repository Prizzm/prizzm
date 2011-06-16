class ProductInvitationsController < ApplicationController


  def view_invitation
    @product = Product.find(params[:id])
    @item = Item.new(:product_id => @product.id)
    session[:new_item] = params[:id]
  end 

  def accept_invitation
    @item = Item.create(params[:item])
    flash[:notice] = "Thanks for sharing item #{@item.product.name}"
    @user = current_user #create_account for visitor that doesn't have one
    @user.items << @item
    #share_on_facebook
    message = {:message => "#{@user.first_name} has just left an opinion on the #{@item.product.name} on Prizzm.", :link => url_for([@user, @item]), :picture => @item.product.images.first.image.url}
    puts message
    Facebook.post_message(message, @user.access_token) 
    sign_in_and_redirect home_url, :event => :authentication
  end 

  private

  # TODO: insert public item page (not exist yet)
  def share_on_facebook
    item_show_page = url_for(@item)
    message = "User #{@user.first_name} has just left an opinion on #{@item.name} on Prizzm. #{item_show_page}"
    puts message
    #Facebook.post_message(message, current_user.access_token) 
  end
end
