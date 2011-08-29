class RegistrationsController < Devise::RegistrationsController
  def update    
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      sign_in resource_name, resource, :bypass => true
      #redirect_to after_update_path_for(resource)
    else
      @user = resource
      @errors = resource.errors
      respond_to do |format|
        format.js { }
        #format.html {
        #  clean_up_passwords(resource)
        #  render_with_scope :edit
        #}
      end
    end
  end

  def edit
    @user = current_user
    render :layout => false
  end
end
