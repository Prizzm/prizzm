# encoding: utf-8
# README for carrierwave gem
# http://rubydoc.info/gems/carrierwave/frames

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::ImageScience
  include CarrierWave::RMagick


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
  process :resize_and_pad => [400, 400]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_and_pad => [75, 75]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    ['jpg', 'jpeg', 'gif', 'png', '']
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end


#   https://github.com/locomotivecms/engine/blob/master/app/uploaders/asset_uploader.rb
  #process :set_content_type
  #def set_content_type(*args)
  #  value = :other

  #  content_type = file.content_type == 'application/octet-stream' ? File.mime_type?(original_filename) : file.content_type

  #  self.class.content_types.each_pair do |type, rules|
  #    rules.each do |rule|
  #      case rule
  #      when String then value = type if content_type == rule
  #      when Regexp then value = type if (content_type =~ rule) == 0
  #      end
  #    end
  #  end

  #  #puts "contenttype #{value}"
  #  #puts "cachee naem #{cache_name}"
  #  #puts"extension #{extension_from_content_type content_type}"
  #  model.content_type = value
  #end

  #def cache_name
    #new_cache_name = super
    #if File.extname(new_cache_name).blank?
      #new_cache_name # + extension_from_content_type 
    #end
  #end

  #def self.content_types
  #  {
  #    :image => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/x-icon'],
  #    :media => [/^video/, 'application/x-shockwave-flash', 'application/x-swf', /^audio/, 'application/ogg', 'application/x-mp3'],
  #    :pdf => ['application/pdf', 'application/x-pdf'],
  #    :stylesheet => ['text/css'],
  #    :javascript => ['text/javascript', 'text/js', 'application/x-javascript', 'application/javascript'],
  #    :font => ['application/x-font-ttf', 'application/vnd.ms-fontobject', 'image/svg+xml', 'application/x-woff']
  #  }
  #end


  #  def extension_from_content_type content_type
  #    case content_type
  #      when 'image/gif'
  #        '.gif'
  #      when 'image/png'
  #        '.png'
  #      when 'image/jpeg', 'image/pjpeg'
  #        '.jpg'
  #      else
  #        ''
  #    end
  #  end



end
