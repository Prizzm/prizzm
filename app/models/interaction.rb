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
  belongs_to :item
end
