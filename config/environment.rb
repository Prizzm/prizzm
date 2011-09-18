# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Prizzm::Application.initialize!
ENV['MONGOHQ_URL'] = 'mongodb://prizzm:prizzm@staff.mongohq.com:10046/prizzm'

if ENV['HEROKU_APP'] ==  'prizzm-development'
  Haml::Template.options[:ugly] = false
end

