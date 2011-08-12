class CasesController < InheritedResources::Base
  before_filter :load_user

  def index
    @cases = current_user.cases.all
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

  def update_privacy
    @case = current_user.case.find(params[:id])
    old_privacy = @case.privacy
    @case.update_attribute(:privacy, new_item_privacy(@case.privacy))
    render :json => {:object_privacy  => @case.privacy,  :old_privacy => old_privacy }
  end 

protected
  def load_user
    @user = current_user
  end 
end
