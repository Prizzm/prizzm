class RegistrationsController < Devise::RegistrationsController
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
end
