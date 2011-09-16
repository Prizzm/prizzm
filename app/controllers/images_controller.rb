class ImagesController < ApplicationController

  before_filter :find_imageable
  before_filter :find_or_build_image, :except => :create

  def create
    @image = @imageable.images.build params[:image]
    respond_to do |format|
      if @image.save
        format.js do
          html = render_to_string(:partial => 'image_thumbnail', :locals => {:img => @image})
          render :text => html
        end
      else
        flash[:error] = "We were unable to upload your image"
      end
    end 
  end

  def destroy
    respond_to do |format|
      if @image.destroy
        format.js {render :json => params[:index]}
        format.html {redirect_to @imageable}
      else
        flash[:error] = 'Photo could not be deleted'
      end
    end 
  end

 private

  def find_imageable
    @imageable = params[:imageable_type].camelize.constantize.find(params[:imageable_id])
  end 

  def find_or_build_image
    @image = params[:id] ? @imageable.images.find(params[:id]) : @imageable.images.build(params[:image])
  end
end
