class User < ActiveRecord::Base
  include UserImageable
  include Models::User::DeviseExt

  has_one  :profile, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :products, :through => :items

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :location, :photo, :profile_attributes
  delegate :first_name, :last_name,  :phone_number, :phone_number=, :location, :location=, :photo,  :to  => :profile

  accepts_nested_attributes_for :profile

  acts_as_follower
  acts_as_followable

  def name
    "#{first_name} #{last_name}"
  end

  def wanted_items
    items.wanted
  end

  def owned_items
    items.owned
  end

  def already_wants? product
    items.wanted.collect(&:product_id).include? product.id
  end

  def already_owns? product
    items.owned.collect(&:product_id).include? product.id
  end

  def wants product
    if already_wants? product
      item = items.wanted.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'want')
      self.items << item
    end
    item
  end 

  def owns product
    if already_owns? product
      item = items.owned.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'have')
      self.items << item
    end
    item
  end

end
