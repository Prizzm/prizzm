desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour % 4 == 0 # run every four hours
    puts "Updating feed..."
    puts "done."
  end

  puts "Cron job exxecuted at #{Time.now}"

  if Time.now.hour == 0 # run at midnight
    puts "Midnight"
  end
end
