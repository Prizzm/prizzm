class CasesController < InheritedResources::Base
  before_filter :load_user

  def index
    @cases = Case.publicly.all
  end

  def show
    @case = Case.find(params[:id])
  end 

  def new
    @case = Case.new
    render :layout => false
  end

  def create 
    @case = Case.new(params[:case])
    @case.user = current_user
    if @case.save
      redirect_to @case 
    else
      render "new"
    end
  end

  def update 
    @case = current_user.cases.find(params[:id])
    if @case.update_attributes(params[:case])
      respond_to do |format|
        format.html {redirect_to @case}
        format.json {head :ok}
      end 
    end
  end


protected
  def load_user
    @user = current_user
  end 
end
