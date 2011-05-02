# == Schema Information
# Schema version: 20110426103432
#
# Table name: items
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  url         :text
#  description :text
#  itemtype    :string(255)
#  rating      :integer
#  position    :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  belongs_to :user
  has_many :tags, :dependent => :nullify
  has_many :interactions, :through => :tags

  acts_as_list :scope => :user

  # https://github.com/rails/acts_as_list/issues/10
  # default_scope order('position asc')
end
