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
    product_id = session[:new_item]
    @product_invitation = ProductInvitation.find_by_encrypted_id(params[:encrypted_id])
    signin_type = params[:signin_type]
    @review = params[:product_review]
    #if params[:product_review][:id].empty?
      #@review = ProductReview.create(params[:product_review])
    session[:review] = params[:product_review]
    review_text = params[:product_review][:content]
    @product = @product_invitation.product
    @item = Item.create({:product_id => @product.id, :name => @product.name, :tag_list => 'have', :review => review_text, :invitation_status => "incomplete"})
    begin
      @item.add_image_from_url @product.main_image
    rescue CarrierWave::DownloadError
      image_url = request.protocol + request.host_with_port + @product.main_image
      @item.add_image_from_url image_url
    end
    session[:accepted_item] = @item.id


    # If user chose to signing with facebook
    if signin_type == 'facebook'
      session[:signin_type] = 'facebook'
      redirect_to user_omniauth_authorize_path(:facebook)
    # If user choose not to use Facebook, show them the login form
    elsif signin_type == 'standard'
      session[:signin_type] = 'standard'
      redirect_to new_user_session_path
    end
    #end
  end
end
