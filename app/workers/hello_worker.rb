require 'pp'
class HelloWorker 
  extend HerokuResqueAutoScale if Rails.env.production?

  @queue = :test_queue

  def self.perform
    @events = Notification.all.to_a
    ses = AWS::SimpleEmailService.new
    ses.send_email(:to => "sid137@gmail.com", :from => "notifications@prizzm.com", :subject => "Sent from Resque", :body_text => "#{pp @events}    \n\n\n\n\n#{ENV}" )
  end
end
