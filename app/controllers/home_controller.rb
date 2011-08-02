class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user

    respond_to do |format|
      format.html 
      format.json  { render :json => @user }
    end
  end

  def dashboard

  end

  def make_data
    current_user.make_real
    redirect_to home_url
  end

end
