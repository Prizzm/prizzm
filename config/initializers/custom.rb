require 'cgi'
require 'random'
require 'test_data'
require 'acts_as_follower'

Dir["#{Rails.root}/lib/models/**/*.rb"].each { |file| require file }
#Dir["#{Rails.root}/lib/gems/**/*.rb"].each { |file| require file }

Hash.send :include, Hashie::HashExtensions
