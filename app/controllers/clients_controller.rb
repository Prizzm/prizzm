class ClientsController < InheritedResources::Base
  before_filter :authenticate_company!
  before_filter :load_company
  layout 'corporate'

  def new
    @client = current_company.clients.new
  end

  def create
    @client = current_company.clients.create(params[:client])
    if @client.save
      redirect_to [current_company, @client] 
    else
      render 'new'
    end
  end

  def edit
    @client = current_company.clients.find(params[:id])
  end

  def update
    @client = current_company.clients.find(params[:id])
    if @client.update_attributes(params[:client])
      redirect_to [current_company, @client] 
    else
      render 'edit'
    end
  end

  def destroy
    current_company.clients.find(params[:id]).destroy
    redirect_to company_clients_path(current_company)
  end

protected

  def load_company
    @company = Company.find(params[:company_id]) 
  end 

end
