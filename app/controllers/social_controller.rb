class SocialController < ApplicationController

  def create_recommendation
	render :layout => nil
  end

  def publish_recommendation
    item = current_user.items.find(params[:item_id])
    message = {
      :message => params[:message], 
      :picture => item.main_image_thumb, 
      :link => public_owned_item_url(item), 
      :description => item.description
    }
    Facebook.post_message(message, current_user.access_token) 

    redirect_to home_url, :notice => "You item recomendation has been published"
    ActivityLogger.user_recommend_item :user => current_user, :item => item, :message => params[:message]
  end

  def new_recommendation_request
    render :layout => nil
  end

  def send_recommendation_request
    item = current_user.items.find(params[:item_id])
    message = {
      :message => params[:message], 
      :picture => item.main_image_thumb, 
      :link => public_wanted_item_url(item), 
      :description => item.description
    }
    Facebook.post_message(message, current_user.access_token) 

    redirect_to home_url, :notice => "You message has been published"
    ActivityLogger.user_asks_item :user => current_user, :item => item, :message => params[:message]
  end

end
