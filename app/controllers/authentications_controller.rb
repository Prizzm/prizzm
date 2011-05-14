class AuthenticationsController < ApplicationController
  def create
    puts "asaaaaaaaaaaa"
    omni_auth = request.env["omniauth.auth"]
    render :text => omni_auth.to_yaml, :content_type => "text/yaml"
    #handle_omni_auth(omni_auth)
  end

  def handle_omni_auth(omni_auth)
    authentication = Authentication.find_by_provider_or_uid(omni_auth['provider'], omni_auth['uid'])
    if authentication
      user = authentication.user
    else
      user = User.create
      user.profile.create(:first_name => omni_auth['user_info']['first_name'], 
                          :last_name => omni_auth['user_info']['last_name'],
                          :photo_url => omni_auth['user_info']['image'])
      user.authentications.create_from_omni_auth(omni_auth)
    end

    # log user in
    # redirect_to ...
  end
end
