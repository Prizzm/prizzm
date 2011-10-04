class Client < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates_presence_of :email
end
