class Profile < ActiveRecord::Base

  belongs_to :user
  before_save :ensure_photo_present

  mount_uploader :photo, UserImageUploader

  private

  def ensure_photo_present
    self.photo ||= "http://lorempixum.com/200/200/people/" + (1..10).to_a.rand.to_s 
  end 
end
