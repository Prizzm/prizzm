class ComposerController < ApplicationController

  def link
      url = "www.google.com" #|| params[:url].strip
      render :text => get_url(url)
  end

protected

  def get_url url
    begin
    #unless (url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]).nil?
    #unless (url =~ URI::DEFAULT_PARSER.regexp).nil?
      easy = Curl::Easy.new url
      easy.follow_location = true
      easy.http_get
      easy.body_str
    rescue
      ""
    end
  end
end
