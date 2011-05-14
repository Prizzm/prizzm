Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  #provider :facebook, 'APP_ID', 'APP_SECRET'

  provider :facebook, '145939862144756', '123453a717380f9c6f32d4016c09e012', { :client_options => { :ssl => { :ca_path => "/etc/ssl/certs"}}}
  #provider :facebook, '145939862144756', '123453a717380f9c6f32d4016c09e012', { :client_options => { :ssl => { :ca_path => "/private/etc/cups/certs"}}}
end
