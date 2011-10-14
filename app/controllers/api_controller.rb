class ApiController < ApplicationController
  def create_case
    user = User.first(:conditions => {
      :tt_username => params[:username]
    })

    if user.nil? == false
      company = Company.first(:conditions => {
        :name => params[:company]
      })

      if company.nil? == true
        company = Company.create({
          :name     => params[:company],
          :email    => params[:company].match(/^\w+/)[0].downcase + '@prizzm.com',
          :password => (0...8).map{65.+(rand(25)).chr}.join,
          :claimed  => false
        })
      end


      userCase = Case.new({
        :title  => params[:title],
        :privacy => 'public'
      });

      userCase.company  = company
      userCase.user     = user
      userCase.save
    end

    render :nothing => true
  end


  def create_item
    user = User.first(:conditions => {
      :tt_username => params[:username]
    })

    if user.nil? == false
      if params[:possession] == 'have'
        possession = 'have'
      else
        possession = 'want'
      end

      item = Item.create({
        :privacy  => 'public'
      });

      item.tag_list = possession
      item.user     = user
      item.save
    end

    render :nothing => true
  end
end
