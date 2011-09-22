class CasesController < InheritedResources::Base
  before_filter :load_user

  def index
    @cases = Case.publicly.all
  end

  def show
    @case = Case.find(params[:id])

    @account_sid = ACCOUNT_SID
    @auth_token = AUTH_TOKEN

    @appsid = APP_SID

    @cap = Twilio::Util::Capability.new(@account_sid, @auth_token)
    @cap.allow_client_outgoing(@appsid)
    @cap_name = @cap.generate()
    
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

    if params[:case][:company_id].blank? == false
      @case.company = Company.find(params[:case][:company_id])
    elsif params[:company_name].blank? == false
      # To refactor in the future to use separate tables companies and companies_users
      @case.company = Company.new({
        :name     => params[:company_name],
        :email    => params[:company_name].match(/^\w+/)[0].downcase + '@prizzm.com',
        :password => (0...8).map{65.+(rand(25)).chr}.join,
        :claimed  => false
      })
    end

    if params[:case][:product_id].blank? == false
      @case.product = Product.find(params[:case][:product_id]);
      @case.product.company = @case.company
    elsif
      @case.product = Product.new({
        :name => params[:product_name]
      });
      @case.product.company = @case.company
    end

    
    if @case.save
      redirect_to case_path(@case)+"#edit_issue" 
    end
  end


  def update 
    @case = current_user.cases.find(params[:id])

    if params[:case][:company_id].blank? == false
      @case.company = Company.find(params[:case][:company_id])
    elsif params[:company_name].blank? == false
      # To refactor in the future to use separate tables companies and companies_users
      @case.company = Company.new({
        :name     => params[:company_name],
        :email    => params[:company_name].match(/^\w+/)[0].downcase + '@prizzm.com',
        :password => (0...8).map{65.+(rand(25)).chr}.join,
        :claimed  => false
      })
    end

    if params[:case][:product_id].blank? == false
      @case.product = Product.find(params[:case][:product_id])
    elsif
      @case.product = Product.new({
        :name => params[:product_name]
      })
      @case.product.company = @case.company
    end


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
    @user_case = current_user.cases.find(params[:id])
    @user_case.destroy

    respond_to do |format|
      format.js {
        @html_items = render_to_string :partial   => "profile/user_case",
                                       :collection => current_user.cases
      }
    end
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
