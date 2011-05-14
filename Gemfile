# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

gem 'rails' #, :git => 'git://github.com/rails/rails.git'

# Gem to abstract away the dplication common in standard restful controllers
gem 'inherited_resources'

# Allows us to keep an order of a user's items in their collection
gem "acts_as_list"

# Used to simplify user registrations and logins
gem "devise", :git => "https://github.com/plataformatec/devise.git"

# Might not be used
gem "ajaxful_rating"

# Test helper to make placeholder images
gem "placehold", :git => 'https://github.com/sid137/placehold.git'#:path => '/home/sid137/dev/placehold'

gem "haml-rails"
gem "jquery-rails"

# Facilitates Edit-in-place functionality for certain data fields
gem "best_in_place", :git => 'https://github.com/moabite/best_in_place.git'

# Easily create database models for site simulation
gem "factory_girl_rails"

# Gem for uploading images.  More flexible than "paperclip"
gem "carrierwave", :git => 'https://github.com/jnicklas/carrierwave.git'
gem "fog"

# Apparently needed to make the uploadify multifile uploader work 
gem "flash_cookie_session"

# Used to that we can resize images uploaded through carrierwave, using
# ImageMagick
gem "rmagick"


# Useful for fake data generation
gem "faker"
gem "randexp"
gem "random_data"
gem 'forgery'
gem "lorempixum", :require => 'lorempixum'

gem "hashie"
# gem 'aws-s3', :require => 'aws/s3'
# gem 'bcrypt-ruby', :require => 'bcrypt'

# Provides a shorter syntax for building forms
gem 'formtastic'

gem "hoptoad_notifier"

gem "omniauth"

group :development, :test do
  gem "sqlite3-ruby", :require => 'sqlite3'
  gem "ruby-debug19", :require => 'ruby-debug'

  # nice table displays in Rails console
  gem "hirb"

  # Allows us to push the local development database up to Heroku, and pull the
  # heroku db down locally
  gem "yaml_db"

  # Sass and Blueprint based css framework for dev machine
  # use "compass compile . " to compile css before deployment
  gem "compass", ">=0.11.1"

  # Print a header in app/model/*.rb files, listing the db columns present for
  # each model
  gem "annotate-models"

  # testing
  # controller helper not available for integration tests, so use webrat for now

#  gem "cucumber-rails"
  # gem "selenium-webdriver"
  # gem "rack-test"
  # gem "capybara", :git => 'git://github.com/jnicklas/capybara.git', :require => 'capybara/rspec'
  # gem "launchy"
  # gem 'database_cleaner', :git => 'https://github.com/bmabey/database_cleaner.git'

  # gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  # gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  # gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  # gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  # gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"

  # gem "rspec-rails", "2.6.0.rc2" 
  # gem "rspec",        "2.6.0.rc2"       
  # gem "rspec-core",          "2.6.0.rc2"
  # gem "rspec-expectations",  "2.6.0.rc2"
  # gem "rspec-mocks",         "2.6.0.rc2"
  # gem 'shoulda-matchers'
  # gem "ZenTest"
  # gem "autotest-rails"
end
