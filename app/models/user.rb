class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_one  :profile
  has_many :items, :order => "position"
  has_many :interactions
  has_many :products, :through => :items


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number, :location, :profile_attributes, :access_token
  delegate :first_name, :last_name,  :phone_number, :phone_number=, :location, :location=, :photo_url, :photo_url=,  :to  => :profile

  accepts_nested_attributes_for :profile

  def name
    "#{first_name} #{last_name}"
  end

  def password_require?
    new_record?
  end

  def make_real
    10.times do
      item = Factory :item
      self.items << item
    end
    10.times do
      interaction = Factory :interaction
      self.interactions << interaction
    end
    self.save
  end

  def self.find_for_facebook_oauth(access_token, user)
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

        Profile.create(:user_id => user.id,
                       :first_name => info['first_name'], 
                       :last_name => info['last_name'],
                       :photo_url => info['image'])
        user.save
        user
      end
    else
      # Already sign in.
      user.access_token = credentials['token']
      user.save
      user
    end
  end 

  def self.find_for_twitter_oauth(access_token, user)
    credentials = access_token['credentials']
    info = access_token['user_info']

    # Not signed in.
    if user.nil?
      # Already signed up with Twitter.
      if user = User.find_by_tt_token_and_tt_secret(credentials['token'], credentials['secret'])
        user
      else
        # Create new Prizzm account with Twitter account information.
        user = User.create!(:email => "email@prizzm.com", :password => Devise.friendly_token[0, 20])
        user.tt_token = credentials['token']
        user.tt_secret = credentials['secret']

        Profile.create(:user_id => user.id,
                       :first_name => info['name'],
                       :photo_url => info['image'],
                       :location => info['location']
                      )
        user.save
        user
      end
    else
      # Already sign in.
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
