class Mailer < ActionMailer::Base
  default :from => "notification@prizzm.com"

  def self.notify_comment comment
    recipient_list = recipients_for comment
    
    #   Keeps users who allow comment updates via mail in their settings
    recipient_list = recipient_list.select { |recipient| recipient.settings.receive_comment_updates_via_email }

    Rails.logger.info recipient_list.collect { |r| r.email }
    
    recipient_list.each do |recipient|
      Mailer.case_comment(comment, recipient).deliver
    end
  end

  def case_comment(comment, recipient)
   @comment = comment
   @recipient = recipient
   @commentable = comment.commentable
   mail(:to => "#{recipient.name} <#{recipient.email}>", :subject => "A User has just left a comment on your #{comment.commentable.class.to_s}")
  end 


  def self.recipients_for comment
    # Falling back to older method
    ancestors = comment.ancestors.collect { |c| c.user } 
    ancestry = ancestors + [comment.commentable.user] - [comment.user]
    subscribers = ancestry
    
    # Adds commentable owner to recipient list, remove commenter
    # should work.. problem with getting comment tree root
    #subscribers = comment.root.subscriber_records.collect { |subscription| subscription.user }
    Rails.logger.info "Subscribers: #{subscribers.collect {|u| u.email}}"

    #   filters out unsubscribed muted recipients
    #   Users where not subscribed to this thread's root comment
    #subscribers = subscribers + [comment.commentable.user] - [comment.user]
    Rails.logger.info "Commentable user: #{comment.commentable.user.email}"
    Rails.logger.info "Commenter user: #{comment.user.email}"
    subscribers.uniq 
  end

end
