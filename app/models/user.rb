class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_one  :profile, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :products, :through => :items

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number, :location, :photo, :profile_attributes, :access_token
  delegate :first_name, :last_name,  :phone_number, :phone_number=, :location, :location=, :photo,  :to  => :profile

  accepts_nested_attributes_for :profile

  def name
    "#{first_name} #{last_name}"
  end

  def wanted_items
    items.where("possession_status == 'want'")
  end

  def owned_items
    items.where("possession_status == 'have'")
  end

  def password_require?
    new_record?
  end


  def self.find_for_facebook_oauth(access_token, user=nil)
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

  def self.find_for_twitter_oauth(access_token, user=nil)
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

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
end
