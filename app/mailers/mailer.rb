class Mailer < ActionMailer::Base
  default :from => "notification@prizzm.com"

  def self.notify_comment comment
    recipient_list = recipients_for comment
    # remove commenter from list
    # make list uniq!
    # remove 
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
    [comment.commentable.user]
  end

end
