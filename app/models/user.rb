# == Schema Information
# Schema version: 20110413015531
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_one  :profile
  has_many :items, :order => "position"
  has_many :interactions

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

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    info = access_token['user_info']
    credentials = access_token['credentials']

    if user = User.find_by_email(data["email"])
      user
    else 
      # Create a user with a stub password. 
      email = data['email'] || info['email']
      user = User.create!(:email => email, :password => Devise.friendly_token[0,20])
      user.access_token = credentials['token']

      Profile.create(:user_id => user.id,
                     :first_name => info['first_name'], 
                     :last_name => info['last_name'],
                     :photo_url => info['image'])
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
