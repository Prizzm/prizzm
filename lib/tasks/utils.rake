namespace :db do
  task :rebuild => [:drop, :migrate, "test:prepare"]
  # does NOT work... stick with shell aliases
  # rds='rake db:drop: rake db:migrate: rake db:test:prepare: rake db:seed'
  #task :reseed => [:drop, :migrate, "test:prepare", :seed]
end


