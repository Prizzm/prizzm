class PrizzmInvitation < ActiveRecord::Base
  has_many :sales, :dependent => :destroy
  has_many :clients, :through => :sales, :dependent => :destroy
  belongs_to :product
  belongs_to :company
  belongs_to :incentive

  default_value_for :status, 'unsent'

  def sale_for client
    sales.where(:client_id => client.id).first
  end 

  def sent
    sales.where(:invitation_status => 'sent')
  end

  def unsent
    sales.where(:invitation_status => 'unsent')
  end

  def landing_page_visited
    sales.where(:landing_page_visited => true)
  end

  def wrote_review
    sales.where(:wrote_review => true)
  end

  def logged_in_with_fb
    sales.where(:logged_in_with_fb => true)
  end

  def logged_in_with_prizzm
    sales.where(:logged_in_with_prizzm => true)
  end

  def shared_item_to_fb
    sales.where(:shared_item_to_fb => true)
  end
end
