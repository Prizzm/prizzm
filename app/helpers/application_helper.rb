module ApplicationHelper
  def object_type object
    object.class.to_s.underscore
  end
end
