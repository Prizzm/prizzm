SimpleWorker.configure do |config|
  config.access_key = ENV['SIMPLEWORKER_ACCESS_KEY']
  config.secret_key = ENV['SIMPLEWORKER_SECRET_KEY']
  # Use the line below if you're using an ActiveRecord database
  config.database = Rails.configuration.database_configuration[Rails.env]
end
