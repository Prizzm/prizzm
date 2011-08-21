# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'
gem 'rails', '3.0.9' #, :git => 'git://github.com/rails/rails.git'
gem 'rake', '0.8.7'
gem "haml-rails"
gem "jquery-rails"
# Sends notifications of errors on Production app
gem "hoptoad_notifier"
#  asset packaging
gem "jammit"

gem "sinatra"

gem "acts-as-taggable-on"

# Used to simplify user registrations and logins
# Pined to ref, as there is problem on devise HEAD
gem "devise", :git => "git://github.com/plataformatec/devise.git", :ref => '4964f53a42a3d434ee6d731d6f999d8dae13dada'

#gem "acts_as_follower", :path => '/home/sid137/tracking/acts_as_follower'
gem "acts_as_follower", :git => "git://github.com/sid137/acts_as_follower.git"

# Allows us to keep an order of a user's items in their collection
gem "acts_as_list"
gem "acts_as_commentable_with_threading"

gem "mongoid"
gem "bson_ext"

gem "curb"

#gem "squeel"

#gem "simple_worker" #, :git => "git://github.com/sid137/simple_worker.git"
#gem "simple_worker", :path => "/home/sid137/tracking/simple_worker"
#gem "delayed_job"
#gem "hirefireapp"
gem "resque", :require => 'resque/server'
gem "heroku"

gem "aws-sdk"#, :git => "git clone git://github.com/amazonwebservices/aws-sdk-for-ruby.git"
# Default model values
# https://github.com/FooBarWidget/default_value_for
gem "default_value_for"

# Gem for uploading images.  More flexible than "paperclip"
# fog is for storing files on Amazon, Google...
# remotipart is for uploading files with AJAX
gem "carrierwave", :git => 'git://github.com/jnicklas/carrierwave.git'
gem "fog"
gem 'remotipart', '0.3.4'

# Used to that we can resize images uploaded through carrierwave, using
# ImageMagick
gem "rmagick"

# allows us to have seo friendly urls for our objects
gem "friendly_id", :git => "https://github.com/norman/friendly_id.git"

# allows model and sitewide settings
# https://github.com/100hz/rails-settings
gem "rails-settings", :git => "git://github.com/100hz/rails-settings.git"

# Social Media Gems FB Connect, FB, and Twitter
#gem "faraday", :git => "git://github.com/technoweenie/faraday.git"
gem "omniauth", '0.2.6' #:git => "git://github.com/intridea/omniauth.git"# ,:ref => "b9fe79961ab56041dbf9"
gem "fb_graph"
gem "twitter"#, :git => 'git://github.com/jnunemaker/twitter.git'

# TODO: Why is this in production?
gem 'rails-erd', :git => "git://github.com/voormedia/rails-erd.git"
gem "rest-client"
gem "mechanize"
gem "nokogiri"
gem "hashie"

# For form.
gem 'formtastic'

# TO GO  -  I don't need these dependencies.. get rid of them
# Gem to abstract away the dplication common in standard restful controllers
gem 'inherited_resources', :git => "git://github.com/josevalim/inherited_resources.git"
# Apparently needed to make the uploadify multifile uploader work 
gem "flash_cookie_session"

gem "twilio-ruby"

#gem "squeel"  # Last officially released gem
# gem "squeel", :git => "git://github.com/ernie/squeel.git" # Track git repo
group :development, :test do

  gem "pg"

  gem "sqlite3-ruby", :require => 'sqlite3'
  gem "ruby-debug19", :require => 'ruby-debug'

  gem "guard"
  gem "guard-bundler"
  gem "guard-jammit"
  gem "guard-rails", :git => "git://github.com/johnbintz/guard-rails.git"
  gem "guard-rspec"
  gem "guard-shell"
  gem "guard-compass"
  gem "guard-livereload"
  gem 'rb-fsevent', :require => false 
  gem "growl"
 
  # Used to create an extermal ssh tunnel
  #gem "tunnlr_connector", :require => "tunnlr", :git => "https://sid137@github.com/sid137/tunnlr_connector.git"
  #gem "tunnlr_connector", :require => "tunnlr", :path => "/Users/noli/tracking/tunnlr_connector"

  # Easily create database models for site simulation
  gem "factory_girl_rails"

  # Useful for fake data generation
  gem "faker"
  gem "randexp"
  gem "random_data"
  gem 'forgery'
  gem "lorempixum", :require => 'lorempixum'


  # Needed to run html2haml to convert html to haml
  gem "hpricot"
 
  gem "taps"
  #gem "heroku-rails", :git => "git://github.com/railsjedi/heroku-rails.git"
  gem "heroku-rails", :git => "git://github.com/sid137/heroku-rails.git"

  # nice table displays in Rails console
  gem "hirb"

  gem "facebook_test_users", :git => "git://github.com/sid137/facebook_test_users.git"

  # Allows us to push the local development database up to Heroku, and pull the
  # heroku db down locally
  gem "yaml_db"

  gem "escape_utils"

  # Sass and Blueprint based css framework for dev machine
  # use "compass compile . " to compile css before deployment
  gem "compass", ">=0.11.1"

  # Print a header in app/model/*.rb files, listing the db columns present for
  # each model

  gem "selenium-webdriver"
  gem "rack-test"
  gem "capybara", :require => 'capybara/rspec'
  gem "launchy"
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'

  gem "rspec-core", "2.6.4"
  gem "rspec-rails"# , '2.6.0' #, '2.5.0'
  #gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
  #gem 'shoulda-matchers', :git => 'git://github.com/sid137/shoulda-matchers.git'
  gem "ZenTest"
  gem "autotest-rails"
end
