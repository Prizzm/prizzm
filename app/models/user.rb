class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  extend Loginable

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
    items.where("possession_status = ?", 'want')
  end

  def owned_items
    items.where("possession_status = ?",  'have')
  end

  def password_require?
    new_record?
  end

  def already_wants? product
    wanted_items.collect(&:product_id).include? product.id
  end

  def already_owns? product
    owned_items.collect(&:product_id).include? product.id
  end

  def wants product
    if already_wants? product
      item = wanted_items.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'want')
      self.items << item
    end
    item
  end 

  def owns product
    if already_wants? product
      item = wanted_items.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'have')
      self.items << item
    end
    item
  end

end
