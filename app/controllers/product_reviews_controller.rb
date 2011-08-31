class ProductReviewsController < ApplicationController
  def say
    @product_invitation = ProductInvitation.find_by_encrypted_id(params[:encrypted_id])
    @product_invitation.accepted = params[:acceptstatus]
    @product_invitation.save!
    if @product_invitation.product_review.nil?
      @review = ProductReview.new
    else
      @review = @product_invitation.product_review
    end
    render :layout=>false
  end
  def save
    @review = params[:product_review]
    if !@review["id"]
      @review = ProductReview.create(params[:product_review])
    end
    render :layout=>false
  end

end
