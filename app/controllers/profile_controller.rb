class ProfileController < ApplicationController
  before_filter :load_user

  def show
    render "user_show"
  end 

  def have
      @user = current_user
      @item = Item.new
      @item.images.build

      if current_user.owned_items.count > 0
          render "#{target_user}_have", :layout => "application"
      elsif
          render "user_have_default", :layout => "application"
      end
  end

  def want
    @user = current_user
    @item = Item.new
    @item.images.build

    if current_user.wanted_items.count > 0
        render "#{target_user}_want", :layout => "application"
    elsif
        render "user_want_default", :layout => "application"
    end
  end

  # just show my cases, not others
  def cases
    @user = current_user
    @item = Item.new
    @item.images.build

    @cases = current_user.cases.all

    if @cases.count > 0
      render 'user_cases', :layout => "application"
    elsif
      render 'user_cases_default', :layout => 'application'
    end
  end 

protected
  def load_user
    @user = User.find(params[:id])
  end 

  def target_user
    (@user == current_user) ? 'user' : 'other'
  end
end
