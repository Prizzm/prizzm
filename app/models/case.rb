class Case < ActiveRecord::Base
  include Privatizable
  include Workflow

  acts_as_followable
  acts_as_commentable
  acts_as_taggable

  belongs_to :user
  belongs_to :company
  belongs_to :product
  belongs_to :item

  has_many :subscriber_records, :dependent => :destroy, :as => :subscribable, :class_name => "Subscription"
  has_many :case_files, :dependent => :destroy

  accepts_nested_attributes_for :case_files, :allow_destroy => true


  after_create :log_creation, :create_case_notebook
  before_save :create_or_associate_company, :create_or_associate_product

  scope :recently_updated, order('updated_at DESC')
  scope :recently_created, order('created_at DESC')
  scope :publicly, where(:privacy => 'public')
  scope :privately, where(:privacy => 'private')

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :reserved_words => %(show delete), :allow_nil => true 
  attr_accessor :company_name, :product_name


  default_value_for :privacy, 'private'

  workflow do
    state :unresolved do
      event :resolve, :transitions_to => :resolved
    end

    state :resolved 
  end

  def notebook
    CaseNotebook.where(:case_id => id).first
  end



  protected
    def log_creation
      ActivityLogger.user_open_case :from => self.user,
                                    :for =>[self.company, self.product]
    end


    def create_case_notebook
      CaseNotebook.create(:case_id => id)
    end


    def create_or_associate_company
      if self.company_name.blank? == false
        company = Company.first(:conditions => {
            :name => self.company_name
        })

        if company.nil? == true
          # TODO: Separate company users and company data
          company = Company.create({
            :name     => self.company_name,
            :email    => self.company_name.match(/^\w+/)[0].downcase + '@prizzm.com',
            :password => (0...8).map{65.+(rand(25)).chr}.join,
            :claimed  => false
          })
        end

        self.company = company
      end
    end


    def create_or_associate_product
      if self.product_name.blank? == false
        product = Product.first(:conditions => {
          :name       => self.product_name,
          :company_id => self.company.id
        })

        if product.nil? == true
          product = Product.create({
            :name => self.product_name
          })
          product.company = self.company

          product.save
        end

        self.product = product
      end
    end
end
