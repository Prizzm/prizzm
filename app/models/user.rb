class User < ActiveRecord::Base
  include UserImageable
  include Models::User::DeviseExt

  after_create [:create_user_stream, :log_creation] 
  after_destroy :log_destruction
  after_save :log_update


  #has_one  :profile, :dependent => :destroy
  has_many :items, :dependent => :destroy, :after_add => [:subscribe_to_item]
  has_many :products, :through => :items
  has_many :subscriptions, :dependent => :destroy
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"
  

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true
  mount_uploader :photo, UserImageUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :location, :photo

  
  #validates_uniqueness_of  :subscriptions, :scope => [:user_id, :subscribable_id, :subscribable_type]

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



  # Feed stuff
  def stream
    Stream.where(:user_id => id).first
  end





  # Returns 'true' if user has the product in their wanted items collection,
  # otherwise returns false
  def already_wants? product
    items.wanted.collect(&:product_id).include? product.id
  end

  # Returns 'true' if user has the product in their owned items collection,
  # otherwise returns false
  def already_owns? product
    items.owned.collect(&:product_id).include? product.id
  end

  # If the user alread has an Item representing this Product in their wanted
  # items collection, this does nothing.  Otherwise, it creates a new Item based
  # on nthat product.  In both cases, the item representing the product is
  # returned
  def wants product
    if already_wants? product
      item = items.wanted.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'want')
      self.items << item
      ActivityLogger.user_want_product :for => [self, item, product], :from => self
    end
    item
  end 

  # If the user alread has an Item representing this Product in their owned
  # items collection, this does nothing.  Otherwise, it creates a new Item based
  # on nthat product.  In both cases, the item representing the product is
  # returned
  def owns product
    if already_owns? product
      item = items.owned.where(:product_id => product.id).first
    else
      item = Item.create_from_product(product, :possession_status => 'have')
      self.items << item
      ActivityLogger.user_own_product :for => [self, item, product], :from => self
    end
    item
  end



  # allow us to recieve notifications concerning this object.  If the object is
  # an Item and is associated with a Product, allow allow us to receive
  # event notifications concerning that product
  def subscribe_to object
    subscriptions << Subscription.create(:subscribable => object) unless subscribes_to? object
    if (object.is_a? Item) && (object.product.is_a? Product)
      product = object.product
      company = product.company
      subscriptions << Subscription.create(:subscribable => product) unless subscribes_to? product
      subscriptions << Subscription.create(:subscribable => product.company) unless subscribes_to? product
    end
  end

  # Stop user from receiving event notifications concerning an object.  If that
  # object is an item, that use an associated product, also stop thee user from
  # receiving notifications concerningn that product
  def unsubscribe_from object
    subscriptions.where(:subscribable_id => object.id, :subscribable_type => object.class).destroy_all
    if (object.is_a? Item) && (object.product.is_a? Product)
      product = object.product
      company = product.company
      subscriptions.where(:subscribable_id => product.id, :subscribable_type => product.class).destroy_all
      subscriptions.where(:subscribable_id => company.id, :subscribable_type => company.class).destroy_all
    end
  end

  def subscribes_to? object
    subscriptions.where(:subscribable_id => object.id, :subscribable_type => object.class.to_s).first
  end

  def to_notification
    {:id => self.id, :email => email}
  end

protected

  # This is a callback on teh items association, executed after an item is added
  # to the collection
  def subscribe_to_item item
    subscribe_to item 
  end

  def create_user_stream
    subscribe_to self
    Stream.create(:user_id => self.id)
  end

  # Logs the event that the user has created an account on the site
  def log_creation
    ActivityLogger.user_join :from => self, :for => self
  end 

  # Logs the event that the user has deleted their account on the site
  def log_destruction
    ActivityLogger.user_quit :from => self, :for => self
  end

  def log_update
    ActivityLogger.user_update_profile :from => self, :for => self
  end
end
