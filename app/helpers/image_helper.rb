module ImageHelper

  def image_gallery_for imageable
    render :partial => 'images/images', :locals => {:imageable => imageable}
  end

  def image_uploader_for imageable
    render :partial => 'images/uploader', :locals => {:imageable => imageable, :session_key_name => Rails.application.config.session_options[:key]}
  end
end
