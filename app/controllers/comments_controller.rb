class CommentsController < ApplicationController
  before_filter :load_commentable, :except => [:create_login]

  def create
    @comment = Comment.build_from(@commentable, current_user.id, params[:comment][:body])

    respond_to do |format|
      if @comment.save
        @parent = Comment.find_by_id(params[:parent_id])
        @comment.move_to_child_of(@parent) unless params[:parent_id].blank?
        # TODO : use system that will allow users to unsubscribe
        #Rails.logger.info "Comment root #{@comment.root.body}"
        #Rails.logger.info "Comment root inspect #{@comment.root.inspect}"
        #Rails.logger.info "Comment inspect #{@comment.inspect}"
        #current_user.subscribe_to root_for(@comment) #supposed to be @comment.root but acts as nested set is bonked
        format.html { render :partial => 'comments/comment', :locals  => {:commentable  => @commentable, :comment => @comment} }
      end
    end
    Mailer.notify_comment(@comment)
  end

  def destroy
    comment = @commentable.comment_threads.find(params[:id])    
    @comment_id = comment.id
    @child_ids = comment.children.map { |comment| comment.id }
    comment.hide

    respond_to do |format|
      format.json { render :json => params[:id] }
    end 
  end

protected
  def root_for comment
    comment.ancestors.last || comment
  end

  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end
end

