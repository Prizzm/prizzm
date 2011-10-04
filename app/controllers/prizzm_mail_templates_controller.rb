class PrizzmMailTemplatesController < ApplicationController
  layout 'corporate'

  # GET /prizzm_mail_templates
  # GET /prizzm_mail_templates.xml
  def index
    @prizzm_mail_templates = current_company.prizzm_mail_templates.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prizzm_mail_templates }
    end
  end

  # GET /prizzm_mail_templates/1
  # GET /prizzm_mail_templates/1.xml
  def show
    @prizzm_mail_template = current_company.prizzm_mail_templates.find(params[:id])

    respond_to do |format|
      format.html {render :layout => nil}
      format.xml  { render :xml => @prizzm_mail_template }
    end
  end

  # GET /prizzm_mail_templates/new
  # GET /prizzm_mail_templates/new.xml
  def new
    @prizzm_mail_template = current_company.prizzm_mail_templates.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prizzm_mail_template }
    end
  end

  # GET /prizzm_mail_templates/1/edit
  def edit
    @prizzm_mail_template = current_company.prizzm_mail_templates.find(params[:id])
  end

  # POST /prizzm_mail_templates
  # POST /prizzm_mail_templates.xml
  def create
    @prizzm_mail_template = current_company.prizzm_mail_templates.new(params[:prizzm_mail_template])

    respond_to do |format|
      if @prizzm_mail_template.save
        format.html { redirect_to prizzm_mail_templates_path, :notice => 'Your mail template has been saved'}
        format.xml  { render :xml => @prizzm_mail_template, :status => :created, :location => @prizzm_mail_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prizzm_mail_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prizzm_mail_templates/1
  # PUT /prizzm_mail_templates/1.xml
  def update
    @prizzm_mail_template = current_company.prizzm_mail_templates.find(params[:id])

    respond_to do |format|
      if @prizzm_mail_template.update_attributes(params[:prizzm_mail_template])
        format.html { redirect_to prizzm_mail_templates_path, :notice => 'Your changes have been saved.'}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prizzm_mail_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prizzm_mail_templates/1
  # DELETE /prizzm_mail_templates/1.xml
  def destroy
    @prizzm_mail_template = current_company.prizzm_mail_templates.find(params[:id])
    @prizzm_mail_template.destroy

    respond_to do |format|
      format.html { redirect_to(prizzm_mail_templates_url) }
      format.xml  { head :ok }
    end
  end
end
