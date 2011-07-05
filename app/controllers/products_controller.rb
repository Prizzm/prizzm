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
    products = Product.order('name ASC')
    products = Product.all(:conditions => ["name like ?", params[:term] +'%'])
    render :json  => autocomplete_info_for(products)   
  end 

private
  
  def autocomplete_info_for products
    products.to_json(:methods => [:label, :main_image_thumb, :customer_count], :only => [:id, :rating])
  end
end
