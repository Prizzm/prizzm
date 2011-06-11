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
  belongs_to :item
end
