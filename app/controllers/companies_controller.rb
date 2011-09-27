class CompaniesController < InheritedResources::Base
  
  def index 
    render :layout => "app_alt"
  end
  
  def new
    @company = Company.new
    @company.name = params[:company_name] if params[:company_name]
    render nil
  end

  def edit
    @company = current_company
    render :layout => 'corporate'
  end 

  def update
    @company = current_company
    if @company.update_attributes(params[:company])
      flash[:notice] = 'Your information was sucessfully updated'
      redirect_to company_root_path 
    else
      render 'edit'
    end
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
    companies = Company.where("name ILIKE ?", params[:query]+'%')
                       .limit(5)
                       .order('name ASC')

    render :json  => autocomplete_info_for(companies)   
  end


  private
  def autocomplete_info_for companies
    companies.collect do |company|
      {
        :id    => company.id,
        :value => company.name
      }
    end
  end
end
