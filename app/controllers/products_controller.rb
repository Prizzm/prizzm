class ProductsController < ApplicationController
  def index
    @products = Product.order('name ASC')
    respond_to do |format|
      format.html {render :json  => @products.to_json(:methods => :label, :only => [:label, :id])  } 
    end 
  end 

  def show
    @product = Product.find(params[:id])
  end 

  def search
    # limit results to 6 or so, we we don't reach browser parallel download
    #products = Product.order('name ASC')
    products = Product.where("name ILIKE ?", params[:query]+'%')
    render :json  => autocomplete_info_for(products)   
  end 
  
  def static_search
    #expires_in 2.days.from_now, :private => true
    render :layout => nil
  end

private
  
  def autocomplete_info_for products
    results = products.to_json(:methods => [:name, :main_image_thumb, :main_image, :customer_count, :url, :description], :only => [:id, :rating])
  end
end
