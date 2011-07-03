class WantedItemsController < ApplicationController
  def new
    @item = Item.new(:possession_status => 'want')
  end

  def show
  end

end
