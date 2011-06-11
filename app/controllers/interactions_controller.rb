class InteractionsController < ApplicationController

  def create
    interaction = params[:interaction]
    @interaction = Interaction.new(params[:interaction])
    if @interaction.save
      respond_to do |format|
        format.js {render :partial => 'home/interaction', :locals  => {:interaction  => @interacton}}
      end 
      message = {:message => interaction[:description]}
      Facebook.post_message(message, current_user.access_token) unless interaction[:shared_facebook].nil?
      unless interaction[:shared_twitter].nil?
        TwitterConfig.update_config(@user.tt_token, @user.tt_secret)
        Twitter::Client.new
        Twitter.update(message[:message]) 
      end
    else

    end
  end


  # BUG not working due to interactions model rewrite
  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
