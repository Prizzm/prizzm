namespace :db do
  task :rebuild => [:drop, :migrate, "test:prepare"]
  task :reseed => [:rebuild, :seed]
end


