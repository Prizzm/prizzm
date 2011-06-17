class Item < ActiveRecord::Base
  include Imageable
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :product

  #has_many :tags, :dependent => :nullify
  #has_many :interactions, :through => :tags
  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :interactions, :dependent => :destroy

  # TODO: Add an Item_URL model along with a has_many association Item_URL
  # should have an thumbnail image
  accepts_nested_attributes_for :images, :interactions

  scope :recently_updated, order('created_at DESC')

  acts_as_list :scope => :user

  after_initialize :default_values



  def default_values
    self.privacy ||= 'private'
  end 

  # convience methods
  def has_product?
    !product.nil?
  end

  def parent_company
    product.company if has_product?
  end

end
