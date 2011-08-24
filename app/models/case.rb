class Case < ActiveRecord::Base
  include Privatizable

  belongs_to :user
  belongs_to :company
  belongs_to :item

  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"

  acts_as_followable
  acts_as_commentable
  acts_as_taggable

  after_create :log_creation, :create_case_notebook

  scope :recently_updated, order('updated_at DESC')
  scope :recently_created, order('created_at DESC')
  scope :publicly, where(:privacy => 'public')
  scope :privately, where(:privacy => 'private')

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true 


  default_value_for :privacy, 'private'

  def notebook
    CaseNotebook.where(:case_id => id).first
  end

protected

  def log_creation
    ActivityLogger.user_open_case :from => self.user, :for =>[self.company, self.item] 
  end 

  def create_case_notebook
    CaseNotebook.create(:case_id => id)
  end
end
