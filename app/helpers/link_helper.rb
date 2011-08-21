module LinkHelper
  def follow_link_for object
    if object.is_a? User
      name = object.first_name
    end
    
    if (current_user && current_user.following?(object) )
      link_to "Unfollow", follow_path_for(object), :class => 'follow_control unfollow edit button red', :method => :delete, :remote => true
    elsif current_user
      link_to "Follow", follow_path_for(object), :class => 'follow_control follow edit button blue', :method => :post, :remote => true
    else
      link_to "Follow", login_popup_follow_path(:object_id => object.id, :object_type => object.class.to_s.underscore), :class => 'facebox button blue'
    end
  end

  def block_link_for user
    if current_user.blocks.include? user
      link_to "Unblock", block_path_for(user), :class => 'block_control unblock', :method => :delete, :remote => true
    else
      link_to "Block", block_path_for(user), :class => 'block_control block', :method => :post, :remote => true
    end
  end
end
