class CompanyRegistrationsController < Devise::RegistrationsController
  layout :nil

  def update    
    @company = resource

    if @company.update_attributes(params[:company])
      @back = params[:back]
    else
      @errors = resource.errors
    end

    respond_to do |format|
      format.js { }
    end
  end

  def edit
    @company = current_company
    @back = params[:back]
    render :layout => false
  end

  def new
    @company = build_resource({})
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
