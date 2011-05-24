class Company < ActiveRecord::Base
  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy
end
