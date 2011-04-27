class InteractionsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout nil


  create! do |success, failure| 
    flash = nil
    success.html {render :partial => 'home/interaction', :locals  => {:interaction  => resource}}
  end

  update! do |success, failure| 
    success.html {redirect_to home_path}
  end

  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
