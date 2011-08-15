class Company < ActiveRecord::Base
  include Imageable

  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true 
  
  acts_as_followable

  ADD_TYPES = %w(street_address phone_number website twitter facebook)

  ADD_ICON = {
    "street_address" => "street",
    "phone_number"   => "phone",
    "website"        => "world_link",
    "twitter"        => "tt",
    "facebook"       => "fb"
  }

  ADD_CLASS = {
    "street_address" => "button",
    "phone_number"   => "call",
    "website"        => "button",
    "twitter"        => "button",
    "facebook"       => "button"
  }

  ADD_TEXT = {
    "street_address" => "Go to",
    "phone_number"   => "Call",
    "website"        => "Go to",
    "twitter"        => "Go to",
    "facebook"       => "Go to"
  }
end
