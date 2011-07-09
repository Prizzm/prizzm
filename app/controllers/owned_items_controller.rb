class OwnedItemsController < ApplicationController

  def create
    # Crerate/sign in user if not
    product = Product.find(params[:product_id])
    @item = current_user.owns product
    redirect_to owners_owned_item_view_path(@item.id)
  end

  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 

  def public_view
    @item = Item.find(params[:id]) 
  end
end
