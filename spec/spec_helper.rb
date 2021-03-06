# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Capybara.default_wait_time = 5
#Capybara.ignore_hidden_elements = true
Capybara.ignore_hidden_elements = false
RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.filter_run_excluding :long_term => true
end
# Unleash the power of selenium
# http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Driver.html
# eexplained at
# http://jumpstartlab.com/resources/testing-ruby/integration-testing-with-rspec-capybara-and-selenium/
# use a page.driver.browser during a :js => true test to get a
# Selenium::WebDriver::Driver object
# http://forum.jquery.com/topic/simulating-autocomplete-with-selenium
