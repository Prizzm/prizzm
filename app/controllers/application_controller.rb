class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :object_class, :object_type, :belongs_to_current_user?

  include InheritedResources::DSL

protected

  def object_class object_type
    object_type.classify.constantize
  end

  def object_type object
    object.class.to_s.underscore
  end

  def belongs_to_current_user? object
    object.user == current_user
  end 
end
