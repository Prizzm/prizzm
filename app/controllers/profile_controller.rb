class ProfileController < ApplicationController
  before_filter :load_user

  def show
  end 

  def have
  end

  def want
  end

protected
  def load_user
    @user = User.find(params[:id])
  end 
end
