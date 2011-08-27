class ProfileController < ApplicationController
  before_filter :load_user

  def show
    render "#{target_user}_show"
  end 

  def have
      render "#{target_user}_have"
  end

  def want
    render "#{target_user}_want"
  end

protected
  def load_user
    @user = User.find(params[:id])
  end 

  def target_user
    (@user == current_user) ? 'user' : 'other'
  end
end
