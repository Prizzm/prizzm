class OrphanItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
    session[:new_item] = params[:id]
  end

  def share
    @item = Item.find(params[:id])
    @user = current_user #create_account
    save_item
    add_item_to_user
    share_on_facebook
    redirect_user
  end

  private

  def create_account

  end

  def save_item
   @item.update_attributes(params[:item]) 
  end 

  def add_item_to_user
    #@user.items << @item
  end

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
