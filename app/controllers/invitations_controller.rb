class InvitationsController < Devise::InvitationsController
  def create
    @emails = params[:user][:email].reject { |email| email.blank? }.uniq
    @emails.each { |email| User.invite!({ :email => email }, current_inviter) } if @emails.any?

    #if resource.errors.empty?
    #  set_flash_message :notice, :send_instructions, :email => self.resource.email
    #  respond_with resource, :location => after_invite_path_for(resource)
    #else
    #  respond_with_navigational(resource) { render_with_scope :new }
    #end
  end
end
