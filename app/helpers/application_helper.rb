module ApplicationHelper
  def setup_profile(user)
    user.build_profile
    user
  end

  def format_feed_item event
    name = event["event"] 
    time = event["time"]
    user = event["from"]
    if user["id"] == current_user.id 
      subject = "You" 
      verb = " are "
      possession = " your "
      past = " have "
    else
      subject = user["name"]
      verb = " is "
      possession = " their "
      past = " has "
    end
    linked_subject = link_to subject, profile_path(user["id"])

    output = linked_subject + verb
    case name
    when "user.join"
      output = "#{linked_subject} joined Prizzm"
    when "user.update.profile"
      output = "#{linked_subject} #{past} updated #{possession} profile"
    when "user.follow.user"
      followed = event["data"][0]["email"]
      output << " now following user #{followed}"
    when "user.follow.product"
      followed = event["data"][0]["name"]
      output << " now following the #{followed} "
    when "user.follow.company"
      followed = event["data"][0]["name"]
      output << " now following the #{followed} "
    when "user.rate.item"
      output << " just left a rating for "
    when "user.change.privacy.item"
      output << " sharing "
    else
      "nothiing"
    end
    output.html_safe
  end
end
