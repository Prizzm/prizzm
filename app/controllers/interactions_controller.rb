class InteractionsController < ApplicationController

  def create
    interaction = params[:interaction]
    @item = Item.find(params[:item_id])
    @interaction = Interaction.new(params[:interaction])
    @item.interactions << @interaction
    if @interaction.save
      respond_to do |format|
        format.js {render :partial => 'home/interaction', :locals  => {:interaction  => @interaction}}
      end 
      message = {:message => interaction[:description]}
      #Facebook.post_message(message, current_user.access_token) unless interaction[:shared_facebook].nil?
      #unless interaction[:shared_twitter].nil?
        #TwitterConfig.update_config(@user.tt_token, @user.tt_secret)
        #Twitter::Client.new
        #Twitter.update(message[:message]) 
      #end
    else

    end
  end

  def destroy
    @interaction = Interaction.find(params[:id])    
    @interaction.destroy
    respond_to do |format|
      format.json {render :json => params[:id]}
    end 
  end

  # BUG not working due to interactions model rewrite
  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
