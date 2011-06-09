# == Schema Information
# Schema version: 20110426103432
#
# Table name: interactions
#
#  id              :integer         not null, primary key
#  time_start      :datetime
#  time_end        :datetime
#  rating          :integer
#  contact         :string(255)
#  shared_facebook :boolean
#  shared_twitter  :boolean
#  description     :text
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Interaction < ActiveRecord::Base
  #belongs_to :user
  #has_many :tags, :dependent => :nullify  
  #has_many :items, :through => :tags
  belongs_to :item

  attr_accessor :new_items

  def new_items=(list)
    self.item_ids = list.split(',').map(&:to_i)
  end
end
