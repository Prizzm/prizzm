class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, UserImageUploader

  after_save :log_update

  def log_update
    ActivityLogger.user_update_profile :user => user, :profile => self
  end
end
