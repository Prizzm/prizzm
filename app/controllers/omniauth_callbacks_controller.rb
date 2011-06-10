class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    #pp env["omniauth.auth"]
    if @user.persisted?
      flash[:notice] = "Signed in successfully."
      if signup_share?
        flash[:notice] = "thanks for sharing item #{session[:new_item]}"
        @item = Item.find(session[:new_item])
        @user.items << @item
        sign_in_and_redirect @user, :event => :authentication
        message = {:message => "#{@user.first_name} has just left an opinion on the #{@item.name} on Prizzm.", :link => url_for([@user, @item]), :picture => @item.images.first.image.url}
        puts message
        Facebook.post_message(message, current_user.access_token) 
      else
        sign_in_and_redirect @user, :event => :authentication
      end
      #     https://github.com/intridea/omniauth/wiki/Saving-User-Location
      #     redirect_to request.env['omniauth.origin'] || '/default'
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)
    sign_in_and_redirect @user, :event => :authentication
  end

  private
   
    def signup_share?
      !session[:new_item].nil?
    end 
end
