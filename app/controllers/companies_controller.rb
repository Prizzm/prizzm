class CompaniesController < InheritedResources::Base

  def new
    @company = Company.new
    @company.name = params[:company_name] if params[:company_name]
    render :layout => "app_alt"
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      if params[:item_id]
        
      else
        respond_to do |format|
          format.html { redirect_to @company, :notice => "Company created successfully." }
          format.js
        end
      end
    else
      redirect_to :action => new
    end
  end

  def search
    # limit results to 6 or so, we we don't reach browser parallel download
    #products = Product.order('name ASC')
    companies = Company.where("name ILIKE ?", params[:q]+'%')
    render :json  => autocomplete_info_for(companies)   
  end

  private
  
  def autocomplete_info_for companies
    results = companies.to_json(:methods => [:name, :url], :only => [:id])
    results = companies.to_json(:methods => [:name], :value=> [:name])
    companies.collect {|c| {:name => c.name, :value => c.name}}
  end
end
