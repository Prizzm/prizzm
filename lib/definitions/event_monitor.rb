require 'sinatra/base'

class EventMonitor < Sinatra::Base
  enable :inline_templates
  #set :haml, :layout => Rails.root.join('app/views/layouts/application.html.haml')

  get '/events' do
    @events = Notification.all.to_a
    haml :index
  end

end


__END__

@@layout
!!! 
%html(lang='en')
  %head
    %meta(charset='utf-8')
    %title  Prizzm
    %script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js")
    %script(src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js')
    %script(src='http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.1.7/underscore-min.js')
    %script(src='http://cdnjs.cloudflare.com/ajax/libs/json2/20110223/json2.js')
    %script(src='http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.5.1/backbone-min.js')
  %body
    = yield

@@index
- @events.each do |e|
  #{e.inspect}
