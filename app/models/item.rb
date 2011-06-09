class Item < ActiveRecord::Base
  include Imageable

  belongs_to :user
  belongs_to :product

  #has_many :tags, :dependent => :nullify
  #has_many :interactions, :through => :tags
  has_many :images, :class_name => 'ItemImage', :dependent => :destroy
  has_many :interactions, :dependent => :destroy

  acts_as_list :scope => :user

end
