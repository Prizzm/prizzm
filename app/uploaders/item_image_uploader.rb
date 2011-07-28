# encoding: utf-8
class ItemImageUploader < ImageUploader
  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     "/images/default-item-image.png" 
   end
end
