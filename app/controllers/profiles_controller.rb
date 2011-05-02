class ProfilesController < InheritedResources::Base
  #belongs_to :user, :singleton => true
  respond_to :html, :json

  create! do |success, failure| 
    success.html {redirect_to root_path}
  end

  update! do |success, failure| 
    success.html {redirect_to root_path}
  end

  def resource
    current_user.profile
  end 
end
