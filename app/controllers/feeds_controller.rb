class FeedsController < ApplicationController
  def show
    @feed = current_user.stream.feed
  end

end
