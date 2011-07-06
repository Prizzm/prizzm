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
    #products = Product.all(:conditions => ["name like ?", params[:term] +'%'])
    #products = Product.all(:conditions => ["name like ?", params[:query] +'%'])
    render :json  => autocomplete_info_for(products)   
  end 

private
  
  def autocomplete_info_for products
    #query = params[:query]
    #suggestions =  products.collect { |p| p.name}
    #data = products.collect do |p| 
      #{:label => p.label, :main_image_thumb => p.main_image_thumb, :customer_count => p.customer_count, :id => p.id, :rating => p.rating}
    #end
    #output = {:query => query, :suggestions => suggestions, :data => data }
    results = products.to_json(:methods => [:label, :main_image_thumb, :customer_count], :only => [:id, :rating])
  end
end
