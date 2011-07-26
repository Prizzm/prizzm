require 'simple_worker'

class LogWorker < SimpleWorker::Base

  def run
    ses = AWS::SimpleEmailService.new
    ses.send_email(:to => "sid137@gmail.com", :from => "notifications@prizzm.com", :subject => "Sent from SimpleWorker", :body_text => "Nice Job!" )
    log "Hello World"
  end
end
