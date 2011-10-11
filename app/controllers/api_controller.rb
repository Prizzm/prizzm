class ApiController < ApplicationController
  def create_item
    user = User.find(:first, 
      :conditions => {
        :tt_username => params[:username]
      }
    )

    if user.nil? == false
      company = Company.find(:first,
        :conditions => {:name => params[:company]}
      )

      if company.nil? == true
        company = Company.create({
          :name     => params[:company],
          :email    => params[:company].match(/^\w+/)[0].downcase + '@prizzm.com',
          :password => (0...8).map{65.+(rand(25)).chr}.join,
          :claimed  => false
        })
      end



      product = Product.find(:first, 
        :conditions => {:name => params[:product]}
      )

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


      item = Item.new({
        :tag_list => possession,
        :privacy  => 'public'
      });

      item.product  = product
      item.company  = company
      item.user     = user
      item.save
    end

    render :nothing
  end
end
