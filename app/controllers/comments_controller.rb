class CommentsController < ApplicationController
  before_filter :load_commentable, :except => [:create_login, :post_to_facebook]

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
        format.js { }
      end
    end
    Mailer.notify_comment(@comment)
  end

  def destroy
    comment = @commentable.comment_threads.find(params[:id])    
    nested_comments = nested_comments_of(comment)

    comment.hide
    nested_comments.each { |nc| nc.hide }

    @comment_id = comment.id
    @child_ids = nested_comments.map { |nc| nc.id }

    respond_to do |format|
      format.js { }
    end 
  end

  def post_to_facebook
    comment = Comment.find(params[:comment_id])
    fb_user = FbGraph::User.me(current_user.access_token)
    link = params[:link]
    @errors = []

    begin
      fb_user.feed!(
        :message => "#{comment.user.name} comments on Prizzm",
        :name => comment.commentable_type.constantize.find(comment.commentable_id).name,
        :link => link,
        :description => comment.body.limit(300)
      )
    rescue Exception => e
      logger.info "error => #{e.message}"
      @errors << e.message
    end

    render :nothing => true
  end

protected

  def root_for comment
    comment.ancestors.last || comment
  end

  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end

  def nested_comments_of(comment)
    @nested_comments = []
    collect_children_for(comment)
    @nested_comments
  end

  # Recursive method for Recursive LLC. :)
  def collect_children_for(comment)
    children = comment.children

    children.each do |child|
      @nested_comments << child
      collect_children_for(child) if child.has_children?
    end
  end
end

