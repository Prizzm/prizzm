require 'simple_worker'

class HelloWorker < SimpleWorker::Base


  attr_accessor :some_param

  def run
    log "Starting HelloWorker #{Time.now}\n"
    log "Hey. I'm a worker job, showing how this cloud-based worker thing works."
    log "I'll sleep for a little bit so you can see the workers running!"
    log "some_param --> #{some_param}\n"
    log "Done running HelloWorker #{Time.now}"
  end


end
