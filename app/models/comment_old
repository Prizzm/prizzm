class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  after_create :log_comment

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at DESC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

protected

  #  This method dectects which attributes were changed from the model update,
  #  and sends a notification signalling each attribute change.  This provides
  #  several benefits over signalling the atribute changes in the controller.
  #  First, we can emit notifications directly from teh model, thus aid in test
  #  data generation and unit testing.  Second, we can have the notifications all
  #  in one central place, as opposed to being scattered throughout the
  #  controllers


  def log_comment
    event_name = "user_comment_#{self.commentable_type.underscore}"
    ActivityLogger.send(event_name,  :from => self.user, :for => [self.commentable], :data => self)
  end
end
