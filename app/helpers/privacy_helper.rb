module PrivacyHelper
  def privacy_control_for object
    render :partial => 'privacy/privacy_controls', :locals => {:object => object } if (object.user == current_user)
  end
end
