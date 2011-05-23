class Facebook
  def self.post_message(message, token)
    fb_auth = FbGraph::Auth.new(Facebook.config[:app_id], Facebook.config[:app_secret])
    me = FbGraph::User.me(token).fetch
    me.feed!(:message => message)
  end

  def self.config
    @config ||= if ENV['fb_app_id'] && ENV['fb_app_secret'] && ENV['fb_perms']
      {
        :app_id     => ENV['fb_app_id'],
        :app_secret => ENV['fb_app_secret'],
        :perms      => ENV['fb_perms']
      }
    else
      YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
    end
  end
end
