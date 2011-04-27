class Tag < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :item
end
