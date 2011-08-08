module ProfileHelper

  def your_profile?
    @user == current_user
  end


end
