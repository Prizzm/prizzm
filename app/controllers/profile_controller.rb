class ProfileController < ApplicationController
  before_filter :load_user

  def show
    render "#{target_user}_show"
  end 

  def have
      @user = current_user
      @item = Item.new
      @item.images.build
      render "#{target_user}_have", :layout => "application"
  end

  def want
    @user = current_user
    @item = Item.new
    @item.images.build
    render "#{target_user}_want", :layout => "application"
  end

  # just show my cases, not others
  def cases
    @user = current_user
    @item = Item.new
    @item.images.build
    @cases = current_user.cases.all
    render 'user_cases', :layout => "application"
  end 

protected
  def load_user
    @user = User.find(params[:id])
  end 

  def target_user
    (@user == current_user) ? 'user' : 'other'
  end
end
