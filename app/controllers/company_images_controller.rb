class CompanyImagesController < ApplicationController
  before_filter :find_company
  before_filter :find_or_build_image, :except => :create

  def create
    @image = @company.images.build params[:image]
    respond_to do |format|
      if @image.save
        format.js do
          html = render_to_string(:partial => 'companies/company_image_thumbnail', :locals => {:img => @image})
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
        format.html {redirect_to [current_user, @company]}
      else
        flash[:error] = 'Photo could not be deleted'
      end
    end 
  end

 private

 def find_company
   @company = Company.find(params[:company_id])
   raise ActiveRecord::RecordNotFound unless @company
 end

 def find_or_build_image
   @image = params[:id] ? @company.images.find(params[:id]) : @company.images.build(params[:image])
 end
end
