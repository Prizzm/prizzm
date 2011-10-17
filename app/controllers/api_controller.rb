class ApiController < ApplicationController
  def create_case
    screen_name = params[:username]

    user = User.first(:conditions => {
      :tt_username => screen_name
    })

    if user.nil? == true
      Rails.logger.info('Creating user');

      user = User.create!({
        :tt_username => screen_name,
        :username    => screen_name + "-" + Time.now.hash.abs.to_s,
        :password    => (0...8).map{65.+(rand(25)).chr}.join,
        :email       => "twitter_account_#{screen_name}_#{Time.now.hash.abs}@prizzm.com"
      })
    end


    userCase = Case.new({
      :privacy      => 'public',
      :title        => params[:title],
      :company_name => params[:company_name]
    });

    userCase.user = user
    userCase.save

    render :json => case_url(userCase)
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
