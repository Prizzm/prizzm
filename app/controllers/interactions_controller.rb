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

end
