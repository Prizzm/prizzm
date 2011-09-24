# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Prizzm::Application.initialize!
ENV['MONGOHQ_URL'] = 'mongodb://prizzm:prizzm@staff.mongohq.com:10046/prizzm'
ENV['MONGOLAB_URI'] = 'mongodb://heroku_app936124:clnt6mq151j6u9k1a23v4mk97f@dbh44.mongolab.com:27447/heroku_app936124'

if ENV['HEROKU_APP'] ==  'prizzm-development'
  Haml::Template.options[:ugly] = false
end

