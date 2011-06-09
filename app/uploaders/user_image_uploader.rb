# encoding: utf-8
class UserImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::ImageScience
  include CarrierWave::RMagick

  storage :fog
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end


  # Process files as they are uploaded:
  process :resize_and_pad => [50, 50]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  #v#e#r#s#i#o#n #:#t#h#u#m#b #d#o
    #p#r#o#c#e#s#s #:#r#e#s#i#z#e#_#a#n#d#_#p#a#d #=#> #[#7#5#, #7#5#]
  #e#n#d

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    ['jpg', 'jpeg', 'gif', 'png', '']
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end


end
