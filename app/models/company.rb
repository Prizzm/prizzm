class Company < ActiveRecord::Base
  has_many :products, :dependent => :nullify  
  has_many :images, :class_name => 'CompanyImage', :dependent => :destroy

  def add_image_from_url url
    self.images.create(:remote_image_url => url)
  end 
end
