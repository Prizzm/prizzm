class Product < ActiveRecord::Base
  has_many :items, :dependent => :nullify
end
