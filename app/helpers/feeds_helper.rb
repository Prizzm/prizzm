module FeedsHelper
  def trending_brands
    [Company.first] * 4 #limit(8).to_a
  end

  def latest_reviews
    # FIXME: Put as a scope on notifications... not here
    Notification.where(event: "user.update.item.review").limit(3).order_by(:time, :asc).to_a
  end

  def following_list_for user, opts = {:limit => 4 }
    user.events_where("user.follow.user").last(opts[:limit])
  end

  def events_from_user user=current_user
    events = %w(user.follow.* user.update.item.* user.comment.* user.add.item)
    user.events_where(events)
  end

  # TODO: add generic regexes
  def events_about_users opts = {:limit => 4 }
    # FIXME: TO nooisy for your own items.. neeeds better filtering, for
    # example, removingn events about items conceerning actions I took
    #events = %w(user.follow.user user.update.item.* user.comment.* user.add.item)
    events = %w(user.follow.user user.comment.* )
    current_user.events_where(events).last(opts[:limit])
  end

  def events_about_products opts = {:limit => 4 }
    events = %w(user.follow.product user.comment.product)
    current_user.events_where(events).last(opts[:limit])
  end

  def events_about_companies opts = {:limit => 4 }
    events = %w(user.follow.company user.comment.company)
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
    linked_subject = link_to subject, profile_path(user["slug"]), :class => "user"

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
      output << link_to(followed, profile_path(user["slug"]))
    when "user.follow.product"
      product = event["data"][0] 
      followed = product["name"]
      output << " following the "
      output << link_to(followed, product_path(product["cached_slug"]))
    when "user.follow.company"
      company = event["data"][0]
      followed = company["name"]
      output << " now following "
      output << link_to(followed, company_path(company["cached_slug"]))
    when "user.add.item"
      item = event["data"][0]
      output << " added the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
      output << " to their items"
    when "user.remove.item"
    when "user.update.item.rating"
      item = event["data"][0]
      output << " just left a rating of #{pluralize(item["rating"], 'star')} for the "
      # TODO: Differentiate betweeen public link and private link
      # Might want to start handling this in the controller, instead of having 4
      # routes  public/private   want/have
      output << link_to(item["name"], item_path(item["cached_slug"]))
    when "user.update.item.privacy"
      item = event["data"][0]
      output << " just changed the privacy settings for the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
    when "user.update.item.name"
      item = event["data"][0]
      output << " changed the name for the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
    when "user.update.item.review"
      item = event["data"][0]
      output << " updated their review for the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
    when "user.update.item.url"
      item = event["data"][0]
      output << " added a new URL for the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
    when "user.comment.item"
      item = event["data"][0]
      output << " left a comment about the "
      output << link_to(item["name"], item_path(item["cached_slug"]))
    else
      "nothiing"
    end
    output << raw("<div class='timebit'> #{time_ago_in_words Time.at(time)} ago </div> ") if opts[:timestamp]
    output.html_safe
  end

end
