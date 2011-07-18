module LinkHelper

  def follow_link_for object
    if current_user.following? object 
      link_to "Unfollow", follow_path_for(object), :class => 'follow_control unfollow', :method => :delete, :remote => true
    else
      link_to "Follow", follow_path_for(object), :class => 'follow_control follow', :method => :post, :remote => true
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
