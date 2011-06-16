class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    #pp env["omniauth.auth"]
    if @user.persisted?
      if accepted_product_invitation?
        process_accepted_product_invitation
      else
        flash[:notice] = "Signed in successfully."
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
   
    def accepted_product_invitation?
      !session[:new_item].nil?
    end 

    def process_accepted_product_invitation
      @item = Item.create(:product_id => session[:new_item], :privacy => 'public')
      flash[:notice] = "Thanks for talking about your #{@item.product.name}"
      @user.items << @item
      # Must change to public URL once it exists
      message = {:message => "#{@user.first_name} has just left an opinion on the #{@item.product.name} on Prizzm.", :link => shared_item_url(@item), :picture => @item.product.images.first.image.url}
      puts message
      Facebook.post_message(message, @user.access_token) 
      sign_in_and_redirect @user, :event => :authentication
    end 
end
