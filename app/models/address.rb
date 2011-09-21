class Address < ActiveRecord::Base
  belongs_to :company

  validates_presence_of :address, :address_type
end
