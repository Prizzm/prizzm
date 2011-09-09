class MailTemplate < ActiveRecord::Base
  has_many :product_invitations
  belongs_to :product
end
