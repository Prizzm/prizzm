class CompaniesController < InheritedResources::Base

  def new
    @company = Company.new
    @company.name = params[:company_name] if params[:company_name]
    render :layout => nil
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      if params[:item_id]
        
      else
        redirect_to @company, :notice => "Company created successfully."
      end
    else
      redirect_to :action => new
    end
  end

  def search
    # limit results to 6 or so, we we don't reach browser parallel download
    #products = Product.order('name ASC')
    companies = Company.where("name ILIKE ?", params[:query]+'%')
    render :json  => autocomplete_info_for(companies)   
  end

  private
  
  def autocomplete_info_for companies
    results = companies.to_json(:methods => [:name, :url], :only => [:id])
  end
end
