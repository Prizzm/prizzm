class ProfileController < ApplicationController

  def show
    @user = User.find(params[:id])
    render 'my_profile' and return if @user == current_user
    render 'public_profile'
  end 
end
