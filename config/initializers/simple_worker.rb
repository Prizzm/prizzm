#MONGO_CONFIG = YAML.load(ERB.new(File.new(Rails.root.join('config/mongoid.yml')).read).result)
#AWS_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join('config/aws.yml'))).result)

SimpleWorker.configure do |config|
  config.access_key = ENV['SIMPLEWORKER_ACCESS_KEY']
  config.secret_key = ENV['SIMPLEWORKER_SECRET_KEY']
  # Use the line below if you're using an ActiveRecord database
  config.auto_merge = true
  #config.database = Rails.configuration.database_configuration[Rails.env]
  #config.global_attributes[:mongodb_settings] = MONGO_CONFIG[Rails.env]
  #config.global_attributes[:aws_settings] =  AWS_CONFIG[Rails.env]
end
