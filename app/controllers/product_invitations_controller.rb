class ProductInvitationsController < ApplicationController


  def view_invitation
    @product = Product.find(params[:id])
    @item = Item.new(:product_id => @product.id)
    session[:new_item] = params[:id]
  end 

  def accept_invitation
    @item = Item.create(params[:item])
    @user = current_user #create_account for visitor that doesn't have one
    @user.items << @item
    share_on_facebook
    redirect_user
  end 

  private

  # TODO: insert public item page (not exist yet)
  def share_on_facebook
    item_show_page = url_for(@item)
    message = "User #{@user.first_name} has just left an opinion on #{@item.name} on Prizzm. #{item_show_page}"
    puts message
    #Facebook.post_message(message, current_user.access_token) 
  end

  def redirect_user
    respond_to do |format|
      format.html { redirect_to home_url}
      format.js { render 'share' }
    end
  end
end
