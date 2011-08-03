module FeedsHelper

  def following_list_for user, opts = {:limit => 4 }
    user.events_where("user.follow.user").last(opts[:limit])
  end

  def events_about_users opts = {:limit => 4 }
    events = "user.follow.user"
    # user.update.item.*
    # user.comment.*
    # user.add.item
    current_user.events_where(events).last(opts[:limit])
  end

  def events_about_products opts = {:limit => 4 }
    # user.comment.product
    events = "user.follow.product"
    current_user.events_where(events).last(opts[:limit])
  end

  def events_about_companies opts = {:limit => 4 }
    # user.comment.company
    events = "user.follow.company"
    current_user.events_where(events).last(opts[:limit])
  end



  def format_feed_item event, opts = {:timestamp => true}
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
      user = event["data"][0]
      followed = user["id"] == current_user.id ? "You" : user["name"]
      output << " following "
      output << link_to(followed, profile_path(user["id"]))
    when "user.follow.product"
      product = event["data"][0]
      followed = product["name"]
      output << " following the "
      output << link_to(followed, product_path(product["id"]))
    when "user.follow.company"
      company = event["data"][0]
      followed = company["name"]
      output << " now following "
      output << link_to(followed, company_path(company["id"]))
    when "user.add.item"
      item = event["data"][0]
      output << " added the "
      output << link_to(item["name"], item_path(item["id"]))
      output << " to their items"
    when "user.remove.item"
    when "user.update.item.rating"
      item = event["data"][0]
      output << " just left a rating of #{pluralize(item["rating"], 'star')} for the "
      # TODO: Differentiate betweeen public link and private link
      # Might want to start handling this in the controller, instead of having 4
      # routes  public/private   want/have
      output << link_to(item["name"], item_path(item["id"]))
    when "user.update.item.privacy"
      item = event["data"][0]
      output << " just changed the privacy settings for the "
      output << link_to(item["name"], item_path(item["id"]))
    when "user.update.item.name"
      item = event["data"][0]
      output << " changed the name for the "
      output << link_to(item["name"], item_path(item["id"]))
    when "user.update.item.review"
      item = event["data"][0]
      output << " updated their review for the "
      output << link_to(item["name"], item_path(item["id"]))
    when "user.update.item.url"
      item = event["data"][0]
      output << " added a new URL for the "
      output << link_to(item["name"], item_path(item["id"]))
    when "user.comment.item"
      item = event["data"][0]
      output << " left a comment about the "
      output << link_to(item["name"], item_path(item["id"]))
    else
      "nothiing"
    end
    output << raw("<br /> #{time_ago_in_words Time.at(time)} ago ") if opts[:timestamp]
    output.html_safe
  end

end
