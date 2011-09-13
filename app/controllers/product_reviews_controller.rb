class ProductReviewsController < ApplicationController
  def say
    @product_invitation = ProductInvitation.find_by_encrypted_id(params[:encrypted_id])
    
    @product_invitation.accepted = params[:acceptstatus]
    @product_invitation.save!
    session[:new_item] = @product_invitation.product.id
    Rails.logger.debug "Product #{@product_invitation.product.name} has id #{session[:new_item]}"
    if @product_invitation.product_review.nil?
      @review = ProductReview.new
    else
      @review = @product_invitation.product_review
    end
    render :layout=>false
  end

  def save
    @product_invitation = ProductInvitation.find_by_encrypted_id(params[:encrypted_id])
    if params[:product_review]
      @review = params[:product_review]
      if !@review["id"]
        #@review = ProductReview.create(params[:product_review])
        session[:review]=params[:product_review]
        #TODO: save item review
        @item = Item.create({:product_id => session[:new_item], :invitation_status => "incomplete"})
        session[:accepted_item] = @item.id
      end
    end
    render :layout=>false
  end
end
