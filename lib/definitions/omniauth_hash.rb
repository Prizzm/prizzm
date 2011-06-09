class OmniauthHash < Hash

  def initialize
      self[:provider] = ''
      self[:uid] = ''
      self[:user_info] = {
          :name => '',
          :email => '',
          :nickname => '',
          :first_name => '',
          :last_name => '',
          :location => '',
          :description => '',
          :image => '',
          :phone => ''
      }
      self[:credentials] = {
          :token => '',
          :secret => ''
      }
      self[:extra] = {
          :user_hash => {}
      }
  end
end
