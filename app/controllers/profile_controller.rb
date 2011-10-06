class ProfileController < ApplicationController
  def show
    @user = load_user

    render "user_show", :layout => "application"
  end 


  def have
    # What if a user hasn't logged in yet? current_user will be nil then. -Giang
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

    render "#{target_user}_cases", :layout => "application"
  end 

  protected
  def load_user
    @user = User.find(params[:id])
  end 

  def target_user
    (@user == current_user) ? "user" : "other"
  end
end
