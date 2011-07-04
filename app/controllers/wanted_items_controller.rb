class WantedItemsController < ApplicationController
  def new
    @item = Item.new(:possession_status => 'want')
  end

  def show
  end

  def owners_view
    @item = current_user.items.find(params[:id]) 
  end 

end
