class PrizzmInvitation < ActiveRecord::Base
  has_many :sales, :dependent => :destroy
  has_many :clients, :through => :sales, :dependent => :destroy
  belongs_to :product
  belongs_to :company
end
