class Address < ActiveRecord::Base
  belongs_to :company

  validates_presence_of :address, :address_type

  scope :telephone, where(:address_type => 'phone_number')
  scope :street, where(:address_type => 'street_address')
  scope :website, where(:address_type => 'website')
  scope :twitter, where(:address_type => 'twitter')
  scope :facebook, where(:address_type => 'facebook')
end
