require 'cgi'
Dir["#{Rails.root}/lib/models/**/*.rb"].each { |file| require file }
