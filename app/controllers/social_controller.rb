class SocialController < ApplicationController

  def create_recommendation
  end

  def publish_recommendation
    item = Item.find(params[:item_id])
    message = {
      :message => params[:message], 
      :picture => item.product.main_image_thumb, 
      :link => "http://www.google.com",
      :caption => "Great caption",
      :description => item.description
    }
    Facebook.post_message(message, current_user.access_token) 

    redirect_to home_url, :notice => "You item has been published"
  end

  def new_recomendation_request
  end

  def send_recommendation_request
  end

end
