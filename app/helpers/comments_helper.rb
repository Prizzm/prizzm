module CommentsHelper

  def comments_section_for commentable
    render 'comments/comments_section', :commentable => commentable
  end

  def comment_form_for commentable, parent_id = nil
    render 'comments/form', :commentable => commentable, :parent_id => parent_id
  end

  def comment_collection_for commentable
    render :partial => 'comments/comment', :collection => commentable.root_comments, :locals => {:commentable => commentable}
  end

  def is_child_comment? comment
    'reply' if comment.has_children?
  end 
end
