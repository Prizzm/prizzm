class Case < ActiveRecord::Base
  include Privatizable

  belongs_to :user
  belongs_to :company
  belongs_to :item

  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  acts_as_followable
  acts_as_commentable

  after_create :log_creation 

  scope :recently_updated, order('updated_at DESC')
  scope :recently_created, order('created_at DESC')
  scope :publicly, where(:privacy => 'public')
  scope :privately, where(:privacy => 'private')


  default_value_for :privacy, 'private'

protected

  def log_creation
    ActivityLogger.user_open_case :from => self.user, :for =>[self.company, self.item] 
  end 
end
