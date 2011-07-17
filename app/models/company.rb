class Company < ActiveRecord::Base
  include Imageable

  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy
  
  acts_as_followable
end
