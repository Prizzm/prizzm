class RegistrationsController < Devise::RegistrationsController
  layout nil, :only => [:new]

  def update    
    @user = resource

    if @user.update_attributes(params[:user])
      @back = params[:back]
    else
      @errors = resource.errors
    end

    respond_to do |format|
      format.js { }
    end
  end

  def edit
    @user = current_user
    @back = params[:back]
    render :layout => false
  end

  def new
    @user = build_resource({})
    respond_with_navigational(resource){ render_with_scope :new }
  end

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end
end
