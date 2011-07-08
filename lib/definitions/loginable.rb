module Loginable

  def find_for_facebook_oauth(access_token, user=nil)
    data = access_token['extra']['user_hash']
    info = access_token['user_info']
    credentials = access_token['credentials']

    # Not signed in
    if user.nil?
      # Already signed up with FB.
      if user = User.find_by_email(data["email"])
        user.update_attributes(:access_token => credentials['token']) if user.access_token.blank?
        user
      else 
        # Create new acc on Prizzm with FB acc information.
        email = data['email'] || info['email']
        user = User.create!(:email => email, :password => Devise.friendly_token[0,20])
        user.access_token = credentials['token']
        user.create_profile( :first_name => info['first_name'], :last_name => info['last_name'], :remote_photo_url => info["image"])
        user.save
        user
      end
    else
      # Already signed in.
      user.access_token = credentials['token']
      user.save
      user
    end
  end 

  def find_for_twitter_oauth(access_token, user=nil)
    #pp access_token
    credentials = access_token['credentials']
    info = access_token['user_info']

    # Not signed in.
    if user.nil?
      # Already signed up with Twitter.
      if user = User.find_by_tt_token_and_tt_secret(credentials['token'], credentials['secret'])
        user
      else
        # Create new Prizzm account with Twitter account information.
        user = User.create!(:email => "twitter_account@prizzm.com", :password => Devise.friendly_token[0, 20])
        user.tt_token = credentials['token']
        user.tt_secret = credentials['secret']
        user.create_profile( :first_name => info['name'], :location => info['location'], :remote_photo_url => info["image"])
        user.save
        user
      end
    else
      # Already signed in.
      user.tt_token = credentials['token']
      user.tt_secret = credentials['secret']
      user.save
      user
    end
  end

  def new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

end
