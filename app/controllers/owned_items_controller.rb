class OwnedItemsController < ApplicationController
  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 
end
