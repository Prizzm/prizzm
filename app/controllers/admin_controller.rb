class AdminController < ApplicationController
  def index
    @companies = Company.all
    @users = User.all
  end

  def add_invitation
    @product_invitation = ProductInvitation.new
    @company = Company.first
  end

  def send_invitation
    
  end
  def assign_company
    @user = User.find(params[:assign_company]["user"])
    @company = Company.find(params[:assign_company]["company"])
    @company.users << @user
#    render :text=>@company.name
    redirect_to "/accounts/login"
  end
end
