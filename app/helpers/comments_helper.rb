module CommentsHelper
  def comment_form_for commentable
    render :partial => 'comments/form', :locals => {:commentable => commentable}
  end

  def comment_collection_for commentable
    render :partial => 'comments/comment', :collection => commentable.comments.order('created_at desc'), :locals => {:commentable => commentable}
  end
end
