class Product < ActiveRecord::Base
  include Imageable

  belongs_to :company
  has_many :images, :class_name => 'ProductImage', :dependent => :destroy
  has_many :items,  :dependent => :nullify
  has_many :users, :through => :items


  begin "methods for product search autocomplete"
    # JQuery autocomplete expects a 'label attribute'
    def label
      name
    end 

    def main_image
      images.first.image.url
    end

    def main_image_thumb
      images.first.image.thumb.url
    end

    def customer_count
      users.count
    end 
  end
end
