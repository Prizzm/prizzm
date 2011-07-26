class WorkersController < ApplicationController

  def test
    Resque.enqueue HelloWorker
  end

end
