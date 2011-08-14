# encoding: utf-8
class UserImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::ImageScience
  include CarrierWave::RMagick

  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     "/images/default-user-avatar.png" 
   end

  # Process files as they are uploaded:
  process :resize_and_pad => [50, 50]

  version :big do
    process :resize_to_fit => [150, 110]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    ['jpg', 'jpeg', 'gif', 'png']
  end

end
