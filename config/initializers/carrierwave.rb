CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['PRIZZM_S3_ACCESS_KEY_ID'],       # required
    :aws_secret_access_key  => ENV['PRIZZM_S3_SECRET_ACCESS_KEY'],       # required
  }
  config.fog_directory  = 'beta.prizzm.com'                     # required
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.fog_host = 'http://beta.prizzm.com.s3.amazonaws.com'
end
