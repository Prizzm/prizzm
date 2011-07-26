class WorkersController < ApplicationController

  def test
    #worker = HelloWorker.new
    #worker.some_param = "Passing in arrg"
    #worker.queue
    Resque.enqueue HelloWorker
  end

end
