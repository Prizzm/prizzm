module CommentsHelper

  def comments_section_for commentable
    render 'comments/comments_section', :commentable => commentable
  end

  def comment_form_for commentable
    render 'comments/form', :commentable => commentable
  end

  def comment_collection_for commentable
    render :partial => 'comments/comment', :collection => commentable.comments.order('created_at desc'), :locals => {:commentable => commentable}
  end
end
