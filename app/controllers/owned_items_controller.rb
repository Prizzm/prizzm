class OwnedItemsController < ApplicationController
  def create
    # Crerate/sign in user if not
    product = Product.find(params[:product_id])
    @item = current_user.owns product
    #redirect_to owners_owned_item_view_path(@item.id)
    render 'create_review'
  end

  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 

  def public_view
    @item = Item.find(params[:id]) 
  end

  def edit
    @item = Item.find(params[:id])
    render :layout => false
  end

  def update
    item = Item.find(params[:id])
    item.update_attributes(params[:item])
    redirect_to owners_owned_item_view_path(item)
  end
end
