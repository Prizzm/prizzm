class Mailer < ActionMailer::Base
  default :from => "notification@prizzm.com"
  default_url_options[:host] = ENV['URL']

  def self.notify_comment comment
    recipient_list = recipients_for comment
    
    #   Keeps users who allow comment updates via mail in their settings
    #recipient_list = recipient_list.select { |recipient| recipient.settings.receive_comment_updates_via_email }

    Rails.logger.info recipient_list.collect { |r| r.email }
    
    recipient_list.each do |recipient|
      if comment.commentable.is_a? Case
        Mailer.case_comment(comment, recipient).deliver
      elsif comment.commentable.is_a? Item
        Mailer.item_comment(comment, recipient).deliver
      end
    end
  end

  def self.deliver_prizzm_invitation(prizzm_invitation, client=nil)
    if client.nil?
      recipients = prizzm_invitation.clients.all 
      prizzm_invitation.update_attributes({:invitation_sent_at => Time.now, :status => 'sent' })
    else
      recipients = [client]
    end

    recipients.each do |client|
      sale = prizzm_invitation.sale_for(client)
      sale.update_attributes({:invitation_sent_at => Time.now, :invitation_status => 'sent' })
      Rails.logger.info "####################################### Client id: #{client.id}"
      Mailer.prizzm_invitation(prizzm_invitation, client).deliver
    end
  end

  def case_comment(comment, recipient)
   @comment = comment
   @recipient = recipient
   @commentable = comment.commentable
   mail(:to => "#{recipient.name} <#{recipient.email}>", :subject => "A User has just left a comment on your #{comment.commentable.class.to_s}")
  end 

  ##changed on 31-aug-2011 
  ##mailer invitation 
  def product_invite(product, pinvite,hosturl)
    @product = product
    @pinvite = pinvite
    @hosturl = hosturl    
    mail(:from => "#{product.company.name} <#{product.company.name}@#{product.company.name}.prizzm.com>", :to=>"#{pinvite.first_name}  <#{pinvite.email}>", :subject=>"#{product.company.name} thanks you for buying a #{product.name}")
  end
  ##end changed code on 31-aug-2011 , for mailer invitation

  def item_comment(comment, recipient)
   @comment = comment
   @recipient = recipient
   @commentable = comment.commentable
   mail(:to => "#{recipient.name} <#{recipient.email}>", :subject => "A User has just left a comment on your #{comment.commentable.class.to_s}")
  end 

  def prizzm_invitation(prizzm_invitation, client=nil)
    @product = prizzm_invitation.product
    @company = prizzm_invitation.company
    @prizzm_invitation = prizzm_invitation
    @client = client
      mail(:from => "#{prizzm_invitation.company.name} <#{prizzm_invitation.company.email }>", :to=>"#{client.first_name} #{client.last_name}  <#{client.email}>", :subject=>"#{prizzm_invitation.company.name} thanks you for buying a #{prizzm_invitation.product.name}")
  end

  def self.recipients_for comment
    # Falling back to older method
    ancestors = comment.ancestors.collect { |c| c.user } 
    ancestry = ancestors + [comment.commentable.user] - [comment.user]
    subscribers = ancestry
    
    # Adds commentable owner to recipient list, remove commenter
    # should work.. problem with getting comment tree root
    #subscribers = comment.root.subscriber_records.collect { |subscription| subscription.user }
    #
    #
    #
    #Third method, add property recieve_mails_for_child_comments.   If
    #false, just dont send to comment owner
    Rails.logger.info "Subscribers: #{subscribers.collect {|u| u.email}}"

    #   filters out unsubscribed muted recipients
    #   Users where not subscribed to this thread's root comment
    #subscribers = subscribers + [comment.commentable.user] - [comment.user]
    Rails.logger.info "Commentable user: #{comment.commentable.user.email}"
    Rails.logger.info "Commenter user: #{comment.user.email}"
    subscribers.uniq 
  end

end
