class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :tags, :dependent => :nullify
  has_many :interactions, :through => :tags
  has_many :images, :dependent => :destroy

  acts_as_list :scope => :user

  # https://github.com/rails/acts_as_list/issues/10
  # default_scope order('position asc')

  # Interface so we can easily add imagees to an item that are hosted on a
  # remote url
  def add_image_from_url url
    self.images << Image.create(:remote_image_url => url)
  end 
end
