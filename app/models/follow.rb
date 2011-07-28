class Follow < ActiveRecord::Base
  extend ActsAsFollower::FollowerLib
  
  after_create :log_follow
  after_destroy :log_unfollow

  scope :for_follower,        lambda { |follower| where(["follower_id = ? AND follower_type = ?", follower.id, parent_class_name(follower)]) }
  scope :for_followable,      lambda { |followable| where(["followable_id = ? AND followable_type = ?", followable.id, parent_class_name(followable)]) }
  scope :for_follower_type,   lambda { |follower_type| where("follower_type = ?", follower_type) }
  scope :for_followable_type, lambda { |followable_type| where("followable_type = ?", followable_type) }
  scope :recent,              lambda { |from| where(["created_at > ?", (from || 2.weeks.ago).to_s(:db)]) }
  scope :descending,          order("follows.created_at DESC")
  scope :unblocked,           where(:blocked => false)
  scope :blocked,             where(:blocked => true)
  
  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true
  
  def block!
    self.update_attribute(:blocked, true)
  end
  
protected
  def log_follow
    user = User.find(follower_id)
    object = followable_type.constantize.find followable_id
    user.subscribe_to object
    ActivityLogger.user_follow_object :user => user, :object => object
  end 

  def log_unfollow
    user = User.find(follower_id)
    object = followable_type.constantize.find followable_id
    user.unsubscribe_from object
    ActivityLogger.user_unfollow_object :user => user, :object => object
  end

end
