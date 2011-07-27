class Company < ActiveRecord::Base
  include Imageable

  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy
  has_many :addresses
  has_many :subscriptions, :dependent => :destroy, :as => :subscribable

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete) 
  
  acts_as_followable
end
