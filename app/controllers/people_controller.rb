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

    render :layout => "people"
  end


  def following
    @items = Item.joins('INNER JOIN follows ON follows.follower_id = items.user_id')
                 .where(
                   :follows => {
                     :followable_type => 'User',
                     :follower_type   => 'User',
                     :followable_id   => current_user.id
                   },
                   :privacy => "public"
                 )
                 .limit(10)

    render :layout => "people"
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





