class ApiController < ApplicationController
  def create_item
    user = User.first(:conditions => {
      :tt_username => params[:username]
    })

    Rails.logger.info "Is user nil? #{user.nil?}"

    if user.nil? == false
      company = Company.first(:conditions => {
        :name => params[:company]
      })

      Rails.logger.info "Is company nil? #{company.nil?}"

      if company.nil? == true
        company = Company.create({
          :name     => params[:company],
          :email    => params[:company].match(/^\w+/)[0].downcase + '@prizzm.com',
          :password => (0...8).map{65.+(rand(25)).chr}.join,
          :claimed  => false
        })
      end



      product = Product.first( :conditions => {
        :name => params[:product]
      })

      Rails.logger.info "Is product nil? #{product.nil?}"

      if product.nil? == true
        product = Product.new({
          :name => params[:product]
        });
        product.company = company
        product.save
      end


      if params[:possession] == 'have'
        possession = 'have'
      else
        possession = 'want'
      end

      item = Item.create({
        :privacy  => 'public'
      });

      item.tag_list = possession
      item.product  = product
      item.company  = company
      item.user     = user
      item.save!
    end

    render :nothing => true
  end
end
