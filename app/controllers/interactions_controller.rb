class InteractionsController < InheritedResources::Base
  nested_belongs_to :user, :item
  respond_to :html, :json
  layout nil


  create! do |success, failure| 
    success.html {redirect_to root_path}
  end

  update! do |success, failure| 
    success.html {redirect_to root_path}
  end

end
