class FollowsController < ApplicationController
  before_filter :find_object, :only => [:follow, :unfollow]

  def follow
    current_user.follow @object
    render :json => {:following => true, :link => view_context.follow_link_for(@object)}
  end

  def unfollow
    current_user.stop_following @object
    render :json => {:following => false, :link => view_context.follow_link_for(@object)}
  end

  def block
    user = User.find(params[:id])
    current_user.block user
    render :json => {:blocked => true, :link => view_context.block_link_for(user)}
    ActivityLogger.user_block_user :from => current_user, :data => user
    
  end 

  def unblock
    user = User.find(params[:id])
    current_user.unblock user
    render :json => {:blocked => false, :link => view_context.block_link_for(user)}
    ActivityLogger.user_unblock_user :from => current_user, :data => user
  end 

protected

  def find_object
    @object = params[:object].classify.constantize.find(params[:id])
  end 
end
