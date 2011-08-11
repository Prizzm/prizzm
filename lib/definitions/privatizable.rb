# Model must have a string attribute "privacy", which takes on values of either
# "public" or "private"
module Privatizable


  def is_public?
    privacy == "public"
  end

  def is_private?
    !is_public?
  end

  def toggle_privacy
    if privacy == "private"
      self.privacy = "public"
    else
      self.privacy = "private"
    end
    save
  end

end
