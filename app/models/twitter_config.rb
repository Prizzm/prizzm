class TwitterConfig
  def self.config
    @config ||= if ENV['tt_con_id'] && ENV['tt_con_secret']
      {
        :con_id     => ENV['tt_con_id'],
        :con_secret => ENV['tt_con_secret'],
      }
    else
      YAML.load_file("#{Rails.root}/config/twitter.yml")[Rails.env].symbolize_keys
    end
  end

  def self.update_config(oauth_token, oauth_token_secret)
    Twitter.configure do |config|
      config.consumer_key = TwitterConfig.config[:con_id]
      config.consumer_secret = TwitterConfig.config[:con_secret]
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end
  end
end
