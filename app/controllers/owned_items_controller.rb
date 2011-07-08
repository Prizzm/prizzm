class OwnedItemsController < ApplicationController
  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 

  def create
    # Crerate/sign in user if not
    product = Product.find(params[:product_id])
    @item = current_user.owns product
    redirect_to owners_owned_item_view_path(@item.id)
  end
end
