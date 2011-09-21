class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:login_popup]

  def index
    if user_signed_in?
      redirect_to have_path(current_user)
    end
  end

  
  def welcome
  end


  def scrape
    @req_url = params[:url].strip

    if !( @req_url.start_with?("http") || @req_url.start_with?("https") )
      @req_url = "http://" + @req_url
    end

    a = Mechanize.new { |agent|
      #agent.user_agent = "Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.0 Safari/535.1";
      agent.user_agent_alias = 'Linux Mozilla'
    }

    begin
      a.get(@req_url) do |page|        
        @page = page
      end
    rescue
      render :json => nil
      return
    end

    base_uri = URI(@req_url.to_s)

    image_urls = @page.image_urls.map { |i| i.to_s }

    if image_urls.length == 0
      puts "No images Found"

      #TODO: try searching background images
    end

    @title = @page.title
    @desc = "TODO: Extract description from the document."

    @images = image_urls.uniq
    
    # including extra information like title and description if needed later
    render :json => { :images => @images, :title => @title , :description => @desc }
  end


  def login_popup
    @object_id, @object_type = params[:object_id], params[:object_type]
    render :layout => false
  end
end
