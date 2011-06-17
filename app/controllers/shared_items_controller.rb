class SharedItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
    if @item.privacy == 'private'
      flash[:alert] = "You don't have permission to view this item"
      redirect_to root_url
    end
  end
end
