class CasesController < InheritedResources::Base
  before_filter :load_user

  def index
    @cases = Case.publicly.all
  end

  def show
    @case = Case.find(params[:id])
    render :layout => 'layouts/app_alt'
  end 

  def new
    @case = Case.new
    render :layout => false
  end

  def create 
    params[:case][:tag_list] = params[:as_values_tag_list]
    @case = Case.new(params[:case])
    @case.user = current_user
    if @case.save
      redirect_to case_path(@case)+"#edit_issue" 
    end
  end

  def update 
    @case = current_user.cases.find(params[:id])
    if @case.update_attributes(params[:case])
      respond_to do |format|
        format.html {redirect_to @case}
        format.json {head :ok}
        format.js {head :ok}
      end 
    end
  end

  def update_description
    @case = current_user.cases.find(params[:id])
    @case.update_attribute(:description, params[:description])
    render :json => @case.description
  end 

  def destroy
    @case = current_user.cases.find(params[:id])
    @case.destroy
    redirect_to home_path
  end

  def post_to_facebook
    the_case = Case.find(params[:case_id])
    fb_user = FbGraph::User.me(current_user.access_token)
    link = params[:link]
    @errors = []

    begin
      fb_user.feed!(
        :message => params[:message],
        :name => the_case.title,
        :link => link,
        :description => the_case.description.to_s.limit(300)
      )
    rescue Exception => e
      logger.info "error => #{e.message}"
      @errors << e.message
    end
  end

protected
  def load_user
    @user = current_user
  end 
end
