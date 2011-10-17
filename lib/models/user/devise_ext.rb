#  For gem extraction:
#  Dd route to config/routes.rb
#  initializer,t
module Models
  module User
    module DeviseExt
      extend ActiveSupport::Concern

      included do
        devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, :invitable #, :validatable
        attr_accessible :email, :password, :password_confirmation, :remember_me, :access_token, :username
      end
      
      module ClassMethods
        def find_for_facebook_oauth(access_token, user=nil)
          data = access_token['extra']['user_hash']
          info = access_token['user_info']
          credentials = access_token['credentials']

          # Not signed in
          if user.nil?
            # Already signed up with FB.
            if user = find_by_email(data["email"])
              user.update_attributes(:access_token => credentials['token']) #if user.access_token.blank?
              user
            else 
              # Create new acc on Prizzm with FB acc information.
              email = data['email'] || info['email']
              username = email.split('@').first + "-prizzm-#{Time.now.hash.abs}"
              user = create!(:email => email,
                             :password => Devise.friendly_token[0,20],
                             :username => username,
                             :first_name => info['first_name'],
                             :last_name => info['last_name'],
                             :remote_photo_url => info["image"],
                             :access_token => credentials['token']
                            )
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
          screen_name = access_token['extra']['user_hash']['screen_name']
          info          = access_token['user_info']

  

          # Not signed in.
          if user.nil?
            # Already signed up with Twitter.
            if user = find_by_tt_token_and_tt_secret(credentials['token'], credentials['secret'])
              user
            elsif user = find_by_tt_username(screen_name.to_s)
              # Update twitter token/secret
              user.tt_token = credentials['token']
              user.tt_secret = credentials['secret']

              # Update with twitter data
              user.location         = info['location']
              user.first_name       = info['name']
              user.remote_photo_url = info['image']
              user.save

              user
            else
              # Create new Prizzm account with Twitter account information.
              user = create!(:email => "twitter_account_#{screen_name}_#{Time.now.hash.abs}@prizzm.com",
                             :username => screen_name + "-" + Time.now.hash.abs.to_s,
                             :password => Devise.friendly_token[0, 20],
                             :first_name => info['name'],
                             :location => info['location'],
                             :remote_photo_url => info["image"]
                            )
              user.tt_token = credentials['token']
              user.tt_secret = credentials['secret']
              user.tt_username = screen_name
              user.save
              user
            end
          else
            # Already signed in.
            user.tt_token = credentials['token']
            user.tt_secret = credentials['secret']
            user.tt_username = screen_name

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

      module InstanceMethods
        def password_require?
          new_record?
        end
      end
    end
  end
end
