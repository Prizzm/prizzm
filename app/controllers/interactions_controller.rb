class InteractionsController < InheritedResources::Base
  belongs_to :user, :optional => true
  respond_to :html, :json
  layout nil


  create! do |success, failure| 
    flash = nil
    success.html {
      interaction = params[:interaction]
      render :partial => 'home/interaction', :locals  => {:interaction  => resource}
      Facebook.post_message(interaction[:description], current_user.access_token) unless interaction[:shared_facebook].nil?
      unless interaction[:shared_twitter].nil?
        TwitterConfig.update_config(@user.tt_token, @user.tt_secret)
        Twitter::Client.new
        Twitter.update(interaction[:description]) 
      end
    }
  end

  update! do |success, failure| 
    success.html {redirect_to home_path}
  end

  def destroy
    @interaction = current_user.interactions.find(params[:id])
    super do |format|
      format.json  { render :json => params[:id] }
      format.html {redirect_to home_path}
    end
  end

  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
