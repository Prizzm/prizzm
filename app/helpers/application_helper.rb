module ApplicationHelper
  def setup_profile(user)
    user.build_profile
    user
  end

end
