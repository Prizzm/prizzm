class Company < ActiveRecord::Base
  include Imageable

  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 
  
  acts_as_followable
end
