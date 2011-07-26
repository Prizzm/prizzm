class HelloWorker 
  #extend HerokuResqueAutoScale if Rails.env.production?

  @queue = :test_queue

  def self.perform
    puts "Working"
    puts "access key: #{ENV['AMAZON_ACCESS_KEY_ID']}"
    puts " secret key #{ENV['AMAZON_SECRET_ACCESS_KEY']}"
    pp ENV
    ses = AWS::SimpleEmailService.new
    sleep(5)
    ses.send_email(:to => "sid137@gmail.com", :from => "notifications@prizzm.com", :subject => "Sent from Resque", :body_text => "Nice Job!" )
  end
end
