class InteractionsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout nil


  create! do |success, failure| 
    success.html {redirect_to root_path}
  end

  update! do |success, failure| 
    success.html {redirect_to root_path}
  end

  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
