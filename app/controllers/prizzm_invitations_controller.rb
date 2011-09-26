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
end
