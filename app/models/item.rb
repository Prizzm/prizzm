class Item < ActiveRecord::Base
  include Imageable
  include Privatizable

  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :product
  belongs_to :company

  before_update :associate_image
  before_save :create_or_associate_company, :create_or_associate_product

  after_create :create_item_data
  after_update :notify_attribute_changes

  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true

  # TODO: Add an Item_URL model along with a has_many association Item_URL
  # should have an thumbnail image
  accepts_nested_attributes_for :images

  scope :recently_updated, order('updated_at DESC')
  scope :recently_created, order('created_at DESC')
  scope :publicly, where(:privacy => 'public')
  scope :privately, where(:privacy => 'private')
  scope :with_review, where("review NOT LIKE ''")

  acts_as_list :scope => :user
  acts_as_followable
  acts_as_commentable
  acts_as_taggable

  default_value_for :privacy, 'private'

  OPINION = %w(no_opinion i_recommend_this! not_for_me!)

  attr_accessor :company_name
  attr_accessor :product_name, :product_url, :product_image, :product_description
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

  def wanted_count
    # Can't be expected to calculate on no product_id relationships
    if self.product_id.nil?
      return 0
    else
      items = Item.find(:all, :conditions => {
        :privacy    => "public",
        :product_id => self.product_id
      })

      i = 0
      items.each do |item|
        i += 1 if item.tag_list.include?('want')
      end
      return i
    end
  end

  def have_count
    # To reduce code duplicate
    if self.product_id.nil?
      return 0
    else
      items = Item.find(:all, :conditions => {
        :privacy    => "public",
        :product_id => self.product_id
      })

      i = 0
      items.each do |item|
        i += 1 if item.tag_list.include?('have')
      end
      return i
    end
  end



  def owned
    tagged_with('have')
  end

  def wanted
    tagged_with('want')
  end


  # convience methods
  def has_product?
    !product.nil?
  end

  def has_company?
    if has_product? == true
      return (self.product.company.nil? == false)
    else
      return (self.company.nil? == false)
    end
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



  # Obsolete, now stored on products, need to remove
  def associate_image
    if !self.image_url.blank?
      self.images = []
      add_image_from_url self.image_url
    end
  end


  def create_or_associate_company
    if self.company_name.blank? == false
      company = Company.first(:conditions => {
          :name => self.company_name
      })
      
      if company.nil? == true
        # TODO: Separate company users and company data
        company = Company.create({
          :name     => self.company_name,
          :email    => self.company_name.match(/^\w+/)[0].downcase + '@prizzm.com',
          :password => (0...8).map{65.+(rand(25)).chr}.join,
          :claimed  => false
        })
      end

      self.company = company
    end
  end


  def create_or_associate_product
    if self.product_name.blank? == false
      product = Product.first(:conditions => {
        :name       => self.product_name,
        :company_id => self.company.id
      })
    
      if product.nil? == true
        product = Product.create({
          :name        => self.product_name,
          :description => self.product_description,
          :url         => self.product_url
        })
        product.add_image_from_url(self.product_image)
        product.company = self.company

        product.save
      end

      self.product = product
    end
  end


  def create_item_data
    ItemData.create(:item_id => id)
  end
end
