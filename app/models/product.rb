class Product < ActiveRecord::Base
  include Imageable

  belongs_to :company
  has_many :images, :class_name => 'ProductImage', :dependent => :destroy
  has_many :items,  :dependent => :nullify
  has_many :users, :through => :items

  acts_as_followable

  begin "methods for product search autocomplete"
    def customer_count
      users.count
    end 
  end
end
