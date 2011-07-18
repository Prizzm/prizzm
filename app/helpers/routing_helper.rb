module RoutingHelper

  def follow_path_for(object)
    if current_user.following? object 
      unfollow_path(object.class.to_s.downcase, object)
    else
      follow_path(object.class.to_s.downcase, object)
    end
  end

  def block_path_for(user)
    if current_user.blocks.include? user
      unblock_path user
    else
      block_path user
    end
  end

  def item_path_for(item)
    case item.possession_status
    when 'want'
      public_wanted_item_path(item.user, item)
    when 'have'
      public_owned_item_path(item.user, item)
    end
  end 

end
