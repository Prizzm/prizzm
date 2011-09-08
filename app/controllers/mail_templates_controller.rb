class MailTemplatesController < ApplicationController
    def index
    @product = Product.find(params[:product_id])
    @templates = @product.mail_templates
  end

  def new
    @product = Product.find(params[:product_id])
    @mail_template = @product.mail_templates.new
    render  :layout=>false
  end

  def create
    @pinvite = Product.find(params[:product_id]).mail_templates.create(params[:mail_template])
    render :text=> "template created"
#    redirect_to product_mail_templates_path(Product.find(params[:product_id]))
  end

  def show
    @product = Product.find(params[:product_id])
    if params[:id].to_s == "null"
      render :text=>"please add a template"
    else
      @mail_template = MailTemplate.find(params[:id])
      render :layout=>false
#      render :text=>params[:id]
    end
  end
  def destroy
    @mail_template = MailTemplate.find(params[:id])
    @mail_template.destroy
#    render :text=> params.to_s
    redirect_to product_mail_templates_path(Product.find(params[:product_id]))
  end
  def edit
    @product = Product.find(params[:product_id])
    @mail_template = MailTemplate.find(params[:id])
  end
  def update
    @product = Product.find(params[:product_id])
    @product.mail_templates.find(params[:id]).update_attributes(params[:mail_template])
    redirect_to product_mail_templates_path(@product)
  end
end
