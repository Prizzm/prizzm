class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:login_popup]

  def index
    if user_signed_in?
      redirect_to have_path(current_user)
    end
  end

  

  def scrape
    @url = params[:url].strip

    if !(@url.start_with?("http") || @url.start_with?("https") )
      @url = "http://" + @req_url
    end

    mechanize = Mechanize.new do |agent|
      agent.user_agent_alias = 'Linux Mozilla'
    end

    begin
      mechanize.get(@url) do |page|        
        @page = page
      end
    rescue
      return
    end


    @title       = @page.search('title').first.text
    @description = @page.search('meta[name]').reject do |element|
      if element[:name].downcase != 'description'
        true
      end
    end.first[:content]

    @images = @page.image_urls.map do |image|
      image.to_s
    end.uniq

    render :json => {
      :title       => @title,
      :description => @description,
      :images      => @images
    }
  end


  def login_popup
    @object_id, @object_type = params[:object_id], params[:object_type]
    render :layout => false
  end
end
