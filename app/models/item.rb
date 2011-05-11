# == Schema Information
# Schema version: 20110426103432
#
# Table name: items
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  itemtype         :string(255)
#  industry         :string(255)
#  email            :string(255)
#  contact_name     :string(255)
#  address          :string(255)
#  phone_number     :string(255)
#  secondary_number :string(255)
#  facebook         :string(255)
#  twitter          :string(255)
#  url              :text
#  photo_url        :text
#  description      :text
#  rating           :integer
#  position         :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#


class Item < ActiveRecord::Base
  belongs_to :user
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
