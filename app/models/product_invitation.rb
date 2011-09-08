class ProductInvitation < ActiveRecord::Base
  belongs_to :product
  belongs_to :mail_template
#added on 31-aug-2011
 
  has_one    :product_review
  def product
    if self.product_id
      Product.find(self.product_id)
    else
      Product.new
    end
  end
  def mail_template
    if self.mail_template_id
      MailTemplate.find(self.mail_template_id)
    else
      MailTemplate.new
    end
  end
  def name
    self.first_name + " " + self.last_name
  end
end
#end editions on 31-aug-2011