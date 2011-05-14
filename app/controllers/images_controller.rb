class ImagesController < ApplicationController

  before_filter :find_item
  before_filter :find_or_build_image, :except => :create


  def create
    @image = @item.images.build params[:image]
    respond_to do |format|
      if @image.save
        format.js do #render :json => @image.id
          render :text => render_to_string(:partial => 'items/image_thumbnail', :locals => {:img => @image})
        end
      else
        flash[:error] = "We were unable to upload your image"
      end
    end 
  end

  def destroy
    respond_to do |format|
      if @image.destroy
        format.js {head :ok}
        format.html {redirect_to [current_user, @item]}
      else
        flash[:error] = 'Photo could not be deleted'
      end
    end 
  end

 private

 def find_item
   @item = current_user.items.find(params[:item_id])
   raise ActiveRecord::RecordNotFound unless @item
 end

 def find_or_build_image
   @image = params[:id] ? @item.images.find(params[:id]) : @item.images.build(params[:image])
 end

end
