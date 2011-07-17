module RoutingHelper

  def item_path_for(item)
    case item.possession_status
    when 'want'
      public_wanted_item_path(item.user, item)
    when 'have'
      public_owned_item_path(item.user, item)
    end
  end 

end
