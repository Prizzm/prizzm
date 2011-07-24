class WorkersController < ApplicationControlleer

  def test
    log_worker = LogWorker.new
    log_worker.queue
  end

end
