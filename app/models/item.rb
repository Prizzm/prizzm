class Item < ActiveRecord::Base
  include Imageable
  include Privatizable

  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :product
  
  before_update :pre_process

  after_update :notify_attribute_changes

  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :interactions, :dependent => :destroy
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true

  # TODO: Add an Item_URL model along with a has_many association Item_URL
  # should have an thumbnail image
  accepts_nested_attributes_for :images, :interactions

  scope :recently_updated, order('updated_at DESC')
  scope :recently_created, order('created_at DESC')
  scope :owned, where(:possession_status => 'have')
  scope :wanted, where(:possession_status => 'want')
  scope :publicly, where(:privacy => 'public')
  scope :privately, where(:privacy => 'private')
  scope :with_review, where("review NOT LIKE ''")

  acts_as_list :scope => :user
  acts_as_followable
  acts_as_commentable
  acts_as_taggable

  default_value_for :privacy, 'private'
  default_value_for :possession_status, 'want'
  
  attr_accessor :image_url

  # TODO: not using it for now
  # doing it on client side, consider refactoring
  def self.create_from_product(product, options = {})
    item = Item.create({:name => product.name, :description => product.description, :rating => product.rating,  :url => product.url}.merge(options))
    # TODO: This is really slowing down the add item process..  gotta get this
    # outta here
    item.add_image_from_url product.main_image
    #############
    item.product = product
    item
  end 

  # convience methods
  def has_product?
    !product.nil?
  end

  def parent_company
    product.company if has_product?
  end


protected

  #  This method dectects which attributes were changed from the model update,
  #  and sends a notification signalling each attribute change.  This provides
  #  several benefits over signalling the atribute changes in the controller.
  #  First, we can emit notifications directly from teh model, thus aid in test
  #  data generation and unit testing.  Second, we can have the notifications all
  #  in one central place, as opposed to being scattered throughout the
  #  controllers
  def notify_attribute_changes
    ignore = ["updated_at", "user_id"]
    changed.each do |property|
      delta = changes[property]
      event_name = "user_update_item_#{property}" 
      ActivityLogger.send(event_name,  :from => self.user, :for => [self], :changes => delta) unless ignore.include? property
    end 
  end 
  
  def pre_process
    if !self.image_url.blank?
      self.images = []
      add_image_from_url self.image_url
    end
  end
end
