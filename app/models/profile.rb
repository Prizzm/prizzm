# == Schema Information
# Schema version: 20110413015531
#
# Table name: profiles
#
#  id           :integer         not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  phone_number :string(255)
#  location     :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
