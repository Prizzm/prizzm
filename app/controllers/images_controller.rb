class ImagesController < ApplicationController
  before_filter :find_item, :find_or_build_image


  def create
    respond_to do |format|
      unless @image.save
        flash[:error] = "We were unable to upload your image"
      end
      format.js do
        render :text => render_to_string(:partial => 'images/image', :locals => {:image => @image})
      end
    end 
  end

  def destroy
    respond_to do |format|
      unless @image.destroy
        flash[:error] = 'Photo could not be deleted'
      end
      format.js
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
