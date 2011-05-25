CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['PRIZZM_S3_ACCESS_KEY_ID'],       # required
    :aws_secret_access_key  => ENV['PRIZZM_S3_SECRET_ACCESS_KEY'],       # required
    :region                 => 'us-east-1'
  }
  config.fog_directory  = 'beta.prizzm.com'                     # required
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.fog_host = "http://#{config.fog_directory}.s3.amazonaws.com"
  config.fog_public = true
  
  #if Rails.env.production?
     #config.storage = :fog
  #elsif Rails.env.development?
     #config.storage = :file
     ##config.storage = :fog
  #elsif Rails.env.test?
     #config.storage = :file
     #config.storage = :fog
     ##config.enable_processing = false
  #end
end
