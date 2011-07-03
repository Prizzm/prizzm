# encoding: utf-8
class ProductImageUploader < ImageUploader
   def default_url
     "/images/default-product-image.jpg" 
   end
end
