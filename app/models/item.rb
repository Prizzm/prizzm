# == Schema Information
# Schema version: 20110413015531
#
# Table name: items
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  url         :text
#  description :text
#  itemtype    :string(255)
#  rating      :integer
#  user_id     :integer
#  position    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  belongs_to :user
  has_many :interactions

  acts_as_list :scope => :user

  # https://github.com/rails/acts_as_list/issues/10
  # default_scope order('position asc')
end
