class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    #pp env["omniauth.auth"]
    if @user.persisted?
      if accepted_product_invitation?
        sign_in @user, :event => :authentication
        redirect_to process_accepted_product_invitation_path
      else
        flash[:notice] = "Signed in successfully."
        #sign_in_and_redirect @user, :event => :authentication
        sign_in @user, :event => :authentication
        redirect_to :back
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

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private
   
    def accepted_product_invitation?
      !session[:new_item].nil?
    end 
end
