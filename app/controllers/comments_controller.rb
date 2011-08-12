class CommentsController < ApplicationController
  before_filter :load_commentable, :except => [:create_login]

  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { render :partial => 'comments/comment', :locals  => {:commentable  => @commentable, :comment => @comment} }
        format.js   { }
      end
    end
  end

  def destroy
    comment = @commentable.comments.find(params[:id])    
    @comment_id = comment.id
    comment.destroy

    respond_to do |format|
      format.json { render :json => params[:id] }
      format.js   { }
    end 
  end

protected

  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end
end

