class Stream
  include Mongoid::Document

  field :user_id, type: Integer
  field :feed, type: Array

end
