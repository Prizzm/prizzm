require 'aws-sdk'
require 'mongoid'

class TestEmail < SimpleWorker::Base
  attr_accessor :options, :to, :from, :subject, :body

  def initialize(opts={})
    init_mongodb
    @options = opts 
  end

  def run
    ses = AWS.new
    ses.send_email(:to => "sid137@gmail.com", :from => "notifications@prizzm.com", :subject => subject, :body_text => body )
  end

private

  def init_mongodb
    Mongoid.configure do |config|
      config.from_hash(@mongodb_settings)
    end
  end

  def init_aws
    aWS.config
  end
end
