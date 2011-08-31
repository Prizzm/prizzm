class ProductReview < ActiveRecord::Base
#  belongs_to :product
  belongs_to :product_invitation




  def invitation
    if self.product_invitation_id
      ProductInvitation.find(self.product_invitation_id)
    else
      ProductInvitation.new
    end
  end

end
