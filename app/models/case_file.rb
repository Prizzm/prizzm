class CaseFile < ActiveRecord::Base
  include Privatizable

  belongs_to :case
  mount_uploader :casefile, CaseFileUploader

  default_value_for :privacy, 'private'
end
