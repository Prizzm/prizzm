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
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :items, :order => "position"
  has_many :interactions

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number, :location, :profile_attributes
  delegate :first_name, :last_name,  :phone_number, :phone_number=, :location, :location=, :photo_url, :photo_url=,  :to  => :profile

  accepts_nested_attributes_for :profile

  def name
    "#{first_name} #{last_name}"
  end

  def password_require?
    new_record?
  end

  def make_real
    5.times do
      item = Factory :item
      interaction = Factory :interaction
      self.items << item
      self.interactions << interaction
    end
    self.save
  end
end
