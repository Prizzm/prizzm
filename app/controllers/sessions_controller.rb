class SessionsController < Devise::SessionsController
  layout "landing"

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    #respond_with resource, :location => redirect_location(resource_name, resource)

    if params[:object_id].present? 
      object_id, object_type = params[:object_id], params[:object_type]
      other_user = object_type.classify.constantize.find_by_id(object_id.to_i)
      current_user.follow(other_user) unless current_user.following?(other_user)
    end

    redirect_to :back
  end
end
