class UserSettingsController < ApplicationController

  def edit
    @user = current_user 
  end 

  def update
    settings = params[:settings]
    render 'edit'
  end
end
