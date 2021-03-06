require 'erb'

class Facebook
  # http://developers.facebook.com/docs/reference/api/post
  def self.post_message(message, token)
    fb_auth = FbGraph::Auth.new(Facebook.config[:app_id], Facebook.config[:app_secret])
    me = FbGraph::User.me(token).fetch
    me.feed!(message)
  end

  def self.config
    @config ||= YAML.load(ERB.new(File.read("#{Rails.root}/config/facebook.yml")).result)[Rails.env].symbolize_keys
  end
end
