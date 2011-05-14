class InteractionsController < InheritedResources::Base
  belongs_to :user, :optional => true
  respond_to :html, :json
  layout nil


  create! do |success, failure| 
    flash = nil
    success.html {render :partial => 'home/interaction', :locals  => {:interaction  => resource}}
  end

  update! do |success, failure| 
    success.html {redirect_to home_path}
  end

  def destroy
    @interaction = current_user.interactions.find(params[:id])
    super do |format|
      format.json  { render :json => params[:id] }
      format.html {redirect_to home_path}
    end
  end

  def rate
    current_user.interactions.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end
end
