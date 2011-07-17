require 'cgi'
require 'random'
require 'test_data'
Dir["#{Rails.root}/lib/models/**/*.rb"].each { |file| require file }
