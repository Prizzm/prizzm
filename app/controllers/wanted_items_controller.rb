class WantedItemsController < ApplicationController
  def new
    @item = Item.new(:possession_status => 'want')
  end

  def create
    product = Product.find(params[:product_id])
    @item = current_user.wants product
    redirect_to owners_wanted_item_view_path(@item.id)
  end

  def show
  end

  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 

  def public_view
    @item = Item.find(params[:id]) 
  end

end
