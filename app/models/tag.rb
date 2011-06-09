# == Schema Information
# Schema version: 20110426103432
#
# Table name: tags
#
#  id             :integer         not null, primary key
#  interaction_id :integer
#  item_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Tag < ActiveRecord::Base
  #belongs_to :interaction
  #belongs_to :item
end
