class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :object_class, :object_type, :belongs_to_current_user?

  include InheritedResources::DSL

protected

  # Gives the Ruby class of an object input as a string
  # e.g.   object_class "item"  => Item
  def object_class object_type
    object_type.classify.constantize
  end

  # Gives the string representation of a ruby class
  # e.g. object_type @product => "product"
  def object_type object
    object.class.to_s.underscore
  end

  def belongs_to_current_user? object
    object.user == current_user
  end 
end
