class CompanyImage < ActiveRecord::Base
  belongs_to :company
  mount_uploader :image, CompanyImageUploader
end
