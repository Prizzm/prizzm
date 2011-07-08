# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'
gem 'rails', '3.0.9' #, :git => 'git://github.com/rails/rails.git'
gem 'rake', '0.8.7'
gem "haml-rails"
gem "jquery-rails"

# Gem to abstract away the dplication common in standard restful controllers
gem 'inherited_resources'

# Allows us to keep an order of a user's items in their collection
gem "acts_as_list"

# Used to simplify user registrations and logins
# Pined to ref, as there is problem on devise HEAD
gem "devise", :git => "git://github.com/plataformatec/devise.git", :ref => '4964f53a42a3d434ee6d731d6f999d8dae13dada'


# Facilitates Edit-in-place functionality for certain data fields
gem "best_in_place", :git => 'git://github.com/moabite/best_in_place.git'


# Gem for uploading images.  More flexible than "paperclip"
gem "carrierwave", :git => 'git://github.com/jnicklas/carrierwave.git'
gem "fog"

# Apparently needed to make the uploadify multifile uploader work 
gem "flash_cookie_session"

# Used to that we can resize images uploaded through carrierwave, using
# ImageMagick
gem "rmagick"


gem "hashie"
# gem 'aws-s3', :require => 'aws/s3'

# Provides a shorter syntax for building forms
gem 'formtastic'

# Sends notifications of errors on Production app
gem "hoptoad_notifier"

# Social Media Gems FB Connect, FB, and Twitter
#gem "faraday", :git => "git://github.com/technoweenie/faraday.git"
gem "omniauth", '0.2.6' #:git => "git://github.com/intridea/omniauth.git"# ,:ref => "b9fe79961ab56041dbf9"
gem "fb_graph"
gem "twitter"#, :git => 'git://github.com/jnunemaker/twitter.git'


gem "jammit"

gem "rest-client"
gem 'rails-erd', :git => "git://github.com/voormedia/rails-erd.git"
gem "nokogiri"

gem "squeel"  # Last officially released gem
# gem "squeel", :git => "git://github.com/ernie/squeel.git" # Track git repo
group :development, :test do
  ##gem "activerecord-postgresql-adapter"

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
  gem "rb-inotify", :require => false
  gem "libnotify", :require => false
 

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
 
  gem "heroku"
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
