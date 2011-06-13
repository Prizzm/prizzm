class ProductsController < ApplicationController
  def index
    #@products = Product.all(:conditions => ["name like ?", params[:q] +'%'])
    #pp @products
    @products = Product.order('name ASC')
    respond_to do |format|
      format.html {render :text  => @products.map{|p| "#{p.name}"}}
    end 
  end 
end
