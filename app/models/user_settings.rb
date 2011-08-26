class UserSettings
  include Mongoid::Document

  field :user_id, type: Integer
  field :receive_comment_updates_via_email, type: Boolean, default: true
end
