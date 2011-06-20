# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# https://github.com/guard/guard-rails
#
# :port is the port number to run on (default 3000)
# :environment is the environment to use (default development)
# :start_on_start will start the server when starting Guard (default true)
# :force_run kills any process that's holding open the listen port before attempting to (re)start Rails (default false).
# :daemon runs the server as a daemon, without any output to the terminal that ran guard (default false).
# :timeout waits this number of seconds when restarting the Rails server before reporting there's a problem (default 20).
guard 'rails', :force_run => true, do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
  watch('db/schema.rb')
end

# Runs bundle
guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end



guard 'compass', :configuration_file => 'config/compass.rb' do
  watch(/^app\/stylesheets\/(.*)\.s[ac]ss/)
end

# Runs jammit coommand every time a js or css file is modified
guard 'jammit' do
  watch(/^public\/javascripts\/(.*)\.js/)
  watch(/^public\/stylesheets\/(.*)\.css/)
end
 
#guard 'rspec', :version => 2 do
  # Rails example
  #watch(%r{^spec/.+_spec\.rb$})
  #watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  #watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  #watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  #watch('spec/spec_helper.rb')                        { "spec" }
  #watch('config/routes.rb')                           { "spec/routing" }
  #watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs - great, but not yet
  #watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
#end

# Add files and commands to this file, like the example:
#   watch('file/path') { `command(s)` }
#
guard 'shell' do
  watch(/(.*).txt/) {|m| `tail #{m[0]}` }
end

guard 'ego' do
  watch('Guardfile')
end
