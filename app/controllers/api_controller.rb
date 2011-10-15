class ApiController < ApplicationController
  def create_case
    user = User.first(:conditions => {
      :tt_username => params[:username]
    })

    if user.nil? == false
      userCase = Case.new({
        :privacy      => 'public',
        :title        => params[:title],
        :company_name => params[:company_name]
      });

      userCase.user = user
      userCase.save

      render :json => case_url(userCase)
    else
      render :nothing => true
    end
  end


  def create_item
    user = User.first(:conditions => {
      :tt_username => params[:username]
    })

    if user.nil? == false
      if params[:item_possession] == 'have'
        possession = 'have'
      else
        possession = 'want'
      end

      item = Item.create({
        :privacy      => 'public',
        :product_name => params[:product_name],
        :company_name => params[:company_name],
      });

      item.tag_list = possession
      item.user     = user
      item.save
    end

    render :nothing => true
  end
end
