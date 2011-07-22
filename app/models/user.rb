class User < ActiveRecord::Base
  include UserImageable
  include Models::User::DeviseExt

  after_create :log_creation
  after_destroy :log_destruction

  has_one  :profile, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :products, :through => :items
  # TODO: When object gets destroyed, needs to destroy all subscriptions
  has_many :subscriptions, :dependent => :destroy

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :location, :photo, :profile_attributes
  delegate :first_name, :last_name,  :phone_number, :phone_number=, :location, :location=, :photo,  :to  => :profile

  accepts_nested_attributes_for :profile

  validates_uniqueness_of  :subscriptions, :scope => [:user_id, :subscribable_id, :subscribable_type]

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
      ActivityLogger.user_want_product :user => self, :item => item, :product => product
    end
    item
  end 

  def owns product
    if already_owns? product
      item = items.owned.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'have')
      self.items << item
      ActivityLogger.user_own_product :user => self, :item => item, :product => product
    end
    item
  end

  def subscribe_to object
    subscriptions << Subscription.create(:subscribable => object)
  end

  def subscribes_to? object
    subscriptions.where(:subscribable_id => object.id, :subscribable_type => object.class.to_s).first
  end

  def to_notification
    {:id => self.id, :email => email}
  end

  protected
  def log_creation
    ActivityLogger.user_join :user => self
  end 

  def log_destruction
    ActivityLogger.user_quit :user => self
  end
end
