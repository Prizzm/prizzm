# == Schema Information
# Schema version: 20110331162702
#
# Table name: interactions
#
#  id          :integer         not null, primary key
#  item_id     :integer
#  time_start  :datetime
#  time_end    :datetime
#  contact     :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Interaction < ActiveRecord::Base
  belongs_to :user
  has_many :tags, :dependent => :nullify  
  has_many :items, :through => :tags

  attr_accessor :new_items

  def new_items=(list)
    self.item_ids = list.split(',').map(&:to_i)
  end
end
