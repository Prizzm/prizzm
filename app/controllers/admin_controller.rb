class AdminController < ApplicationController
  def index
    
  end

  def add_invitation
    @product_invitation = ProductInvitation.new
    @company = Company.first
  end

  def send_invitation
    
  end

end
