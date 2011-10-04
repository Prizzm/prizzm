class Product < ActiveRecord::Base
  include Imageable

  belongs_to :company
  has_many :images, :class_name => 'ProductImage', :dependent => :destroy
  has_many :items,  :dependent => :nullify
  has_many :users, :through => :items
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"
  has_many :product_invitations, :dependent => :destroy
  has_many :product_reviews, :dependent => :destroy
  has_many :mail_templates, :dependent => :destroy

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 

  validates_presence_of :name

  acts_as_followable

  begin "methods for product search autocomplete"
    def customer_count
      users.count
    end 
    
    def company_name
      if company.nil? == false
        return company.name       
      end
    end
  end
end
