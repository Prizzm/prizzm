class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def index
    @items = Item.find(:all,
      :conditions => {
        :privacy => "public"
      },
      :limit => 10,
      :order => 'created_at DESC'
    )
  end


  def following
    @items = Item.joins('INNER JOIN follows ON follows.followable_id = items.user_id')
                 .where(
                   :follows => {
                     :followable_type => 'User',
                     :follower_type   => 'User',
                     :follower_id     => current_user.id
                   },
                   :privacy => "public"
                 )
                 .limit(10)

  end
  
  def following_list
    @user = current_user
  end


  def search
    like = '%' + params[:query].gsub(/%/, '\%') + '%'

    people = User.find(:all, :conditions => [
        'first_name ILIKE ?', like
      ],
      :limit => 5
    )

    if people.count > 0
      render :js => render_to_string(
        :partial    => 'people/person',
        :collection => people
      )
    else
      render :js => render_to_string(
        :partial => 'people/invite'
      )
    end
  end
end






