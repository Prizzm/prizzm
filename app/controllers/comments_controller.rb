class CommentsController < ApplicationController
  before_filter :load_commentable, :except => [:create_login]

  def create
    @comment = Comment.build_from(@commentable, current_user.id, params[:comment][:body])

    respond_to do |format|
      if @comment.save
        @comment.move_to_child_of(Comment.find_by_id(params[:parent_id])) unless params[:parent_id].blank?
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

  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end
end

