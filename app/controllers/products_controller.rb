class ProductsController < ApplicationController
  layout "corporate"
  def index
    @company = Company.find(params[:company_id])
    @products = @company.products
    #respond_to do |format|
      #format.html {render :json  => @products.to_json(:methods => :label, :only => [:label, :id])  } 
    #end 
  end 

  def new
    @company = current_company
    @product = @company.products.build
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = current_company.products.create(params[:product])
    redirect_to @product
  end

  def edit
    @product = current_company.products.find(params[:id])
  end

  def update
    @product = current_company.products.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to @product
    else
      render 'edit'
    end
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
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to company_products_path(current_company)
  end
private  
  def autocomplete_info_for products
    results = products.to_json(:methods => [:name, :main_image_thumb, :main_image, :customer_count, :url, :description, :company_id, :company_name], :only => [:id, :rating])
  end
end
