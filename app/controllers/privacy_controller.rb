class PrivacyController < ApplicationController
  before_filter :find_object

  def toggle
    @object.toggle_privacy
    render :json => {:object_privacy  => @object.privacy }
  end

protected
  def find_object
    association = params[:object_type].tableize.to_sym
    @object = current_user.send(association).find(params[:id])
  end 
end
