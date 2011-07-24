class LogWorker < SimpleWorker::Base

  def run
    log "Hello World"
  end
end
