class Sale < ActiveRecord::Base
  belongs_to :prizzm_invitation
  belongs_to :client
end
