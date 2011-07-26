require 'simple_worker'

class WorkersController < ApplicationController

  def test
    worker = HelloWorker.new
    worker.some_param = "Passing in arrg"
    worker.queue
  end

end
