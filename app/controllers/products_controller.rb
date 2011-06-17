class ProductsController < ApplicationController
  def index
    #@products = Product.all(:conditions => ["name like ?", params[:term] +'%'])
    #pp @products
    @products = Product.order('name ASC')
    respond_to do |format|
      format.html {render :json  => @products.to_json(:methods => :label, :only => [:label, :id])  } 
    end 
  end 
end
