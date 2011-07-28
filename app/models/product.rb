class Product < ActiveRecord::Base
  include Imageable

  belongs_to :company
  has_many :images, :class_name => 'ProductImage', :dependent => :destroy
  has_many :items,  :dependent => :nullify
  has_many :users, :through => :items
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 

  acts_as_followable

  begin "methods for product search autocomplete"
    def customer_count
      users.count
    end 
  end
end
