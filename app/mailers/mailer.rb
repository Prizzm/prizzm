class Mailer < ActionMailer::Base
  default :from => "notification@prizzm.com"

  def self.notify_comment comment
    recipient_list = recipients_for comment
    # TODO: filter out unsubscribed muted recipients
    #   Users where user.recieve_comment_notifications_by_email? == false
    #   Users where not subscribed to this thread
    
    # removes duplicates
    #recipient_list.uniq.each do |recipient|
      #Mailer.case_comment(comment, recipient).deliver
    #end

    Rails.logger.info recipient_list.uniq.collect { |r| r.email }
  end

  def case_comment(comment, recipient)
   @comment = comment
   @recipient = recipient
   @commentable = comment.commentable
   mail(:to => "#{recipient.name} <#{recipient.email}>", :subject => "A User has just left a comment on your #{comment.commentable.class.to_s}")
  end 


  def self.recipients_for comment
    # Add commentable owner to recipient list, remove commenter
    ancestors = comment.ancestors.collect { |c| c.user } 
    ancestry = ancestors + [comment.commentable.user] - [comment.user]
    ancestry.uniq 
  end

end
