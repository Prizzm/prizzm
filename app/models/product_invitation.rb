class ProductInvitation < ActiveRecord::Base
  belongs_to :product 
#added on 31-aug-2011
 
  has_one    :product_review
  def product
    if self.product_id
      Product.find(self.product_id)
    else
      Product.new
    end
  end
  def name
    self.first_name + " " + self.last_name
  end
end
#end editions on 31-aug-2011