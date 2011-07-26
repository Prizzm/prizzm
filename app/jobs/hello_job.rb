class HelloJob
  extend HerokuResqueAutoScale if Rails.env.production?

  def self.perform
    # Do something long running
    ses = AWS::SimpleEmailService.new
    ses.send_email(:to => "sid137@gmail.com", :from => "notifications@prizzm.com", :subject => "Sent from Resque", :body_text => "Nice Job!" )
  end
end
