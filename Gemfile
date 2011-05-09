# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

gem 'rails' #, :git => 'git://github.com/rails/rails.git'
gem 'inherited_resources'

gem "acts_as_list"
gem "devise", :git => "https://github.com/plataformatec/devise.git"
gem "ajaxful_rating"
gem "placehold", :git => 'https://github.com/sid137/placehold.git'#:path => '/home/sid137/dev/placehold'

gem "haml-rails"
gem "jquery-rails"
gem "best_in_place", :git => 'https://github.com/moabite/best_in_place.git'

gem "factory_girl_rails"

gem "carrierwave"
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
gem 'formtastic'

group :development, :test do
  gem "sqlite3-ruby", :require => 'sqlite3'
  gem "ruby-debug19", :require => 'ruby-debug'

  # nice table displays in Rails console
  gem "hirb"

  # Data export
  gem "yaml_db"

  # css framework for dev machine
  gem "compass"

  # model layer, test data generation
  gem "annotate-models"

  # testing
  # controller helper not available for integration tests, so use webrat for now

#  gem "cucumber-rails"
  gem "selenium-webdriver"
  gem "rack-test"
  gem "capybara", :git => 'git://github.com/jnicklas/capybara.git', :require => 'capybara/rspec'
  gem "launchy"
  #gem 'database_cleaner', :git => 'https://github.com/bmabey/database_cleaner.git'

  #gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  #gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  #gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  #gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  #gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"

  gem "rspec-rails", "2.6.0.rc2" 
  gem "rspec",        "2.6.0.rc2"       
  gem "rspec-core",          "2.6.0.rc2"
  gem "rspec-expectations",  "2.6.0.rc2"
  gem "rspec-mocks",         "2.6.0.rc2"
  gem 'shoulda-matchers'
  gem "ZenTest"
  gem "autotest-rails"
end
