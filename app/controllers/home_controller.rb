class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @server_name = request.env['SERVER_NAME']
    @user = current_user
    @interactions = current_user.interactions.order('created_at desc').all   

    respond_to do |format|
      format.html 
      format.json  { render :json => @user }
    end
  end

  def make_data
    current_user.make_real
    redirect_to home_url
  end

end
