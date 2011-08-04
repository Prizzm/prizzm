class Case < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  belongs_to :item
end
