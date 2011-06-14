class Product < ActiveRecord::Base
  include Imageable

  belongs_to :company
  has_many :images, :class_name => 'ProductImage', :dependent => :destroy
  has_many :items,  :dependent => :nullify
  has_many :users, :through => :items


  # JQuery autocomplete expects a 'label attribute'
  def label
    name
  end 
end
