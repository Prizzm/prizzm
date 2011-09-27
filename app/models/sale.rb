class Sale < ActiveRecord::Base
  belongs_to :prizzm_invitation
  belongs_to :client
  default_value_for :invitation_status, 'unsent'
end
