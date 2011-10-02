require 'lib/twilio-ruby/version'

Gem::Specification.new do |s|
  s.name = 'twilio-ruby'
  s.version = Twilio::VERSION
  s.author = 'Andrew Benton'
  s.email = 'andrew@twilio.com'

  s.description = 'A simple library for communicating with the Twilio REST API, building TwiML, and generating Twilio Client Capability Tokens'
  s.summary = 'A simple library for communicating with the Twilio REST API, building TwiML, and generating Twilio Client Capability Tokens'
  s.homepage = 'http://github.com/twilio/twilio-ruby'

  s.platform = Gem::Platform::RUBY
  s.require_paths = %w[lib]
  s.files = `git ls-files`.split("\n")
  s.test_files = Dir['test/**/*.rb']

  s.add_dependency('multi_json', '>= 1.0.3')
  s.add_dependency('builder', '>= 2.1.2')
  s.add_dependency('jwt', '>= 0.1.2')

  s.add_development_dependency 'rake',    '~> 0.9.0'
  s.add_development_dependency 'rspec',   '~> 2.6.0'
  s.add_development_dependency 'fakeweb', '~> 1.3.0'
  s.add_development_dependency 'rack',    '~> 1.3.0'

  s.extra_rdoc_files = ['README.md', 'README.rdoc', 'examples.rb', 'LICENSE']
  s.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'twilio-ruby', '--main', 'README.md']
end
