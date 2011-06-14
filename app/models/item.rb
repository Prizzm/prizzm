class Item < ActiveRecord::Base
  include Imageable

  belongs_to :user
  belongs_to :product

  #has_many :tags, :dependent => :nullify
  #has_many :interactions, :through => :tags
  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :interactions, :dependent => :destroy

  scope :recently_updated, order('created_at DESC')

  acts_as_list :scope => :user




  # convience methods
  def has_product?
    !product.nil?
  end

  def parent_company
    product.company if has_product?
  end
end
