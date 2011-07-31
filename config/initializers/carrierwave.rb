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
  
  # Crap...why was this here again?
  config.delete_cache_id_after_storage = false
  # Why don't we make it :filee in development?  Well, one problem is, what if I
  # generate a DB locally, and want to push it to the server.  The DB I push
  # will non longeer represent what I have due to the missing server images
  
  if Rails.env.production? || ENV['PUSH_DEMO'] 
     config.storage = :fog
  elsif Rails.env.development?
     config.storage = :file
     #config.storage = :fog
  elsif Rails.env.test?
     config.storage = :file
     #config.storage = :fog
     config.enable_processing = false
  end
end
