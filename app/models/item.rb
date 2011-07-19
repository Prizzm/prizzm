class Item < ActiveRecord::Base
  include Imageable
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :product

  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :interactions, :dependent => :destroy

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 

  # TODO: Add an Item_URL model along with a has_many association Item_URL
  # should have an thumbnail image
  accepts_nested_attributes_for :images, :interactions

  scope :recently_updated, order('created_at DESC')
  scope :owned, where(:possession_status => 'have')
  scope :wanted, where(:possession_status => 'want')
  scope :public, where(:privacy => 'public')
  scope :private, where(:privacy => 'private')

  acts_as_list :scope => :user
  acts_as_followable

  default_value_for :privacy, 'private'
  default_value_for :possession_status, 'want'

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


end
