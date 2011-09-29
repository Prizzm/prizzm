class PrizzmInvitationsController < ApplicationController
  layout 'corporate'
  # GET /prizzm_invitations
  # GET /prizzm_invitations.xml
  def index
    @prizzm_invitations = current_company.prizzm_invitations.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prizzm_invitations }
    end
  end

  # GET /prizzm_invitations/1
  # GET /prizzm_invitations/1.xml
  def show
    @prizzm_invitation = current_company.prizzm_invitations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prizzm_invitation }
    end
  end

  # GET /prizzm_invitations/new
  # GET /prizzm_invitations/new.xml
  def new
    @prizzm_invitation = current_company.prizzm_invitations.new(:name => "New Invitation")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prizzm_invitation }
    end
  end

  # GET /prizzm_invitations/1/edit
  def edit
    @prizzm_invitation = current_company.prizzm_invitations.find(params[:id])
  end

  # POST /prizzm_invitations
  # POST /prizzm_invitations.xml
  def create
    @prizzm_invitation = current_company.prizzm_invitations.new(params[:prizzm_invitation])

    respond_to do |format|
      if @prizzm_invitation.save
        format.html { redirect_to(@prizzm_invitation, :notice => 'Prizzm invitation was successfully created.') }
        format.xml  { render :xml => @prizzm_invitation, :status => :created, :location => @prizzm_invitation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prizzm_invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prizzm_invitations/1
  # PUT /prizzm_invitations/1.xml
  def update
    @prizzm_invitation = current_company.prizzm_invitations.find(params[:id])

    #old_client_ids = @prizzm_invitation.client_ids
    #new_client_ids = params[:clients]
    @prizzm_invitation.client_ids = params[:clients]
    #client_ids = params[:clients]
    #client_ids.each do |cid|
      #client = current_company.clients.find(cid)
      #@prizzm_invitation.
    #end
    respond_to do |format|
      if @prizzm_invitation.update_attributes(params[:prizzm_invitation])
        format.html { redirect_to(@prizzm_invitation, :notice => 'Prizzm invitation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prizzm_invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prizzm_invitations/1
  # DELETE /prizzm_invitations/1.xml
  def destroy
    @prizzm_invitation = current_company.prizzm_invitations.find(params[:id])
    @prizzm_invitation.destroy

    respond_to do |format|
      format.html { redirect_to(prizzm_invitations_url) }
      format.xml  { head :ok }
    end
  end

  def send_invitation
    @prizzm_invitation = current_company.prizzm_invitations.find(params[:id])
    client = current_company.clients.find(params[:client_id]) if params[:client_id]
    Mailer.deliver_prizzm_invitation(@prizzm_invitation, client)
    redirect_to @prizzm_invitation
  end

  def open_invitation
    @invitation = PrizzmInvitation.find(params[:id])
    @client = @invitation.clients.find(params[:client_id])
    @product = @invitation.product
    @company = @invitation.company
    @sale = @invitation.sale_for @client
    @sale.update_attribute('landing_page_visited', true)
    session[:new_item] = @product.id

    Rails.logger.debug "Product #{@product.name} has id #{session[:new_item]}"
    render :layout=>false
  end

  def save_invitation_review
    @invitation = PrizzmInvitation.find(params[:id])
    @client = @invitation.clients.find(params[:client_id])
    @product = @invitation.product
    @company = @invitation.company
    
    signin_type = params[:signin_type]
    session[:review] = params[:review]
    session[:client_id] = @client.id
    session[:invitation_id] = @invitation.id

    review_text = params[:review]

    unless review_text.blank?
      @sale = @invitation.sale_for @client
      @sale.update_attribute('wrote_review', true)
    end

    @item = Item.create({:product_id => @product.id, :name => @product.name, :tag_list => 'have', :review => review_text, :invitation_status => "incomplete"})

    begin
      @item.add_image_from_url @product.main_image
    rescue CarrierWave::DownloadError
      image_url = request.protocol + request.host_with_port + @product.main_image
      @item.add_image_from_url image_url
    end
    session[:accepted_item] = @item.id


    # If user chose to signing with facebook
    if signin_type == 'facebook'
      session[:signin_type] = 'facebook'
      redirect_to user_omniauth_authorize_path(:facebook)
    # If user choose not to use Facebook, show them the login form
    elsif signin_type == 'standard'
      session[:signin_type] = 'standard'
      redirect_to new_user_session_path
    end
  end 

end
