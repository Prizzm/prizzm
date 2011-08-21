class ApplicationController < ActionController::Base
  protect_from_forgery

  include InheritedResources::DSL

protected

  def object_class object_type
    object_type.classify.constantize
  end
end
