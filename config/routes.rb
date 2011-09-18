Prizzm::Application.routes.draw do


  get "corporate/home"

  devise_for :companies, :path => 'corporate',
             :path_names  => {:sign_in => "login", 
                              :sign_out => "logout", 
                              :sign_up => "register" 
                             }

  match 'product_reviews(/:action(/:acceptstatus(/:encrypted_id(.:format))))'=>'product_reviews'
  match "admin(/:action)" => "admin"
  resources :members

  root :to => redirect("/home")
  match 'corporate/home' => 'corporate#home', :as => 'company_root'
  
  get '/login_popup' => 'home#login_popup', :as => 'login_popup'
  get '/login_popup_follow/:object_id/:object_type' => 'home#login_popup', :as => 'login_popup_follow'

  # Routes for main page
  match "/home" => "home#index", :as => "home"

  # Routes for people
  match "/people" => "people#index", :as => "people"
  match "/people/following" => "people#following", :as => "people_following"
  match "/people/find" => "people#find", :as => "people_find"
  match "/people/search" => "people#search", :as => "people_search"

  match "/profile/:id" => "profile#show", :as => "profile"
  get '/:id/has' => 'profile#have', :as => 'have'
  get '/:id/wants' => 'profile#want', :as => 'want'
  get '/:id/cases' => 'profile#cases', :as => 'user_cases'


  scope '/:taggable_type/:id' do
    resources :tags, :except => :destroy
  end

  delete '/:taggable_type/:id/tags' => 'tags#destroy', :as => 'destroy_tag'

  #route for getting images for a given page URL i.e. scrape
  match "/home/scrape" => "home#scrape", :as  => "scrape"

  resources :user_settings, :as => 'settings'

  # Routes to enable product autocomplete
  resources :products do
    get 'search', :on => :collection
    resources :product_invitations do
      collection do
        get 'refresh_mail_templates'
      end
    end
    resources :mail_templates
  end

  resources :cases do
    resources :notes
    match 'post_to_facebook' => 'cases#post_to_facebook'
  end

  scope '/:imageable_type/:imageable_id' do
    resources :images
  end

  match 'post_to_facebook/:comment_id' => 'comments#post_to_facebook', :as => "comment_post_to_facebook"
  match 'post_to_twitter/:comment_id' => 'comments#post_to_twitter', :as => "comment_post_to_twitter"

  # Comments - this route makes the comments controller response to a
  # polymorphic types
  scope '/:commentable_type/:commentable_id' do
    resources :comments
  end

  ##############################    NOT YET IMPLEMENTED   #############################
  # compositions
  get '/composer/new' => 'composer#new', :as => 'new_composition'
  post '/composer/link' => 'composer#link', :as => 'link_composer'

  ########################################################################################



  put '/privacy/toggle/:object_type/:id' => 'privacy#toggle', :as => 'toggle_privacy'

  get '/:user_id/item/:id' => 'items#show', :as => 'show_item'
  # get '/:user_id/case/:id' => 'cases#show', :as => 'show_item'





  ##############################    TO BE DELETED    #############################
  # Wanted items
  get '/wanted/:id' => 'wanted_items#owners_view', :as => 'owners_wanted_item_view'
  post '/wanted/:product_id' => 'wanted_items#create', :as => 'add_wanted_item'
  get '/:user_id/wants/:id' => 'wanted_items#public_view', :as => 'public_wanted_item'

  get  '/ask/:item_id' => 'social#new_recommendation_request', :as => 'new_advice'
  post '/ask/:item_id' => 'social#send_recommendation_request', :as => 'publish_advice'


  # Owned Items
  get '/owned/:id/edit' => 'owned_items#edit', :as => 'edit_owned_item'
  match '/owned/:id/update' => 'owned_items#update', :as => 'update_owned_item'
  get '/owned/:id' => 'owned_items#owners_view', :as => 'owners_owned_item_view'
  post '/owned/:product_id' => 'owned_items#create', :as => 'add_owned_item'
  get '/:user_id/owns/:id' => 'owned_items#public_view', :as => 'public_owned_item'
  ########################################################################################





  # Following things
  post '/follow/:object/:id' => 'follows#follow', :as => 'follow'
  delete '/unfollow/:object/:id' => 'follows#unfollow', :as => 'unfollow'
  post '/block/:id' => 'follows#block', :as => 'block'
  delete '/unblock/:id' => 'follows#unblock', :as => 'unblock'



  # TODO: Start using this route for generic rating
  #put '/rate/:object_type/:object_id', :as => 'rating'




  get  '/recommend/:item_id' => 'social#create_recommendation', :as => 'create_recommendation'
  post '/recommend/:item_id' => 'social#publish_recommendation', :as => 'publish_recommendation'



  ######################################        DEVISE       #############################
  # User Login and account registration
  devise_for :users, :path => "accounts", 
             :controllers => {:registrations => "registrations", 
                              :omniauth_callbacks => "omniauth_callbacks", 
                              :sessions => "sessions", 
                              :invitations => "invitations",
                              :passwords => "passwords"
                             },
             :path_names  => {:sign_in => "login", 
                              :sign_out => "logout", 
                              :sign_up => "register" 
                             }

  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  ########################################################################################

  resources :companies do
    resources :products 
    resources :addresses
    get 'search', :on => :collection
  end 
 

  ##############################    TO REFaCTOR    #############################
  resources :users do
    resources :items do
      match 'share' => 'items#share'
      match 'set_company' => 'items#set_company'
    end
  end

  match '/items/:item_id/images/:id/index/:index' => 'images#destroy'
  match '/companies/:company_id/images/:id/index/:index' => 'company_images#destroy'

  post '/save_opinion' => 'items#save_opinion', :as => 'item_save_opinion'

  resources :items
  resources :items do
    resources :images, :only => [:create, :destroy]
    match 'post_to_facebook' => 'items#post_to_facebook'
  end

  resources :companies do
    resources :products
    resources :company_images, :only => [:create, :destroy]
  end


  put '/update_item_review/:id' => 'items#update_review', :as => 'update_item_review'
  put '/update_item_name' => 'items#update_item_name', :as => 'update_item_name'
  put '/update_item_company/:id' => 'items#update_company', :as => 'update_item_company'
  post 'items/rate', :as => :update_item_rating
  ########################################################################################





  # Routes for item invitation use cases
#  resources :product_invitations
  get  '/invitation/:id'    => 'product_invitations#view_invitation', :as  => 'view_item_invitation'
  post '/invitation'        => 'product_invitations#accept_invitation', :as => 'accept_item_invitation'
  # FIXME:  Should be using a 'GET' for routes that have side effects, but we
  # can't redirect using a 'POST' method.  Used in omniauth_callback/product_invitations
  get '/process_invitation' => 'product_invitations#process_accepted_product_invitation', :as => 'process_accepted_product_invitation'

  get '/share_review' => 'product_invitations#share_review', :as => 'share_review'
  post '/post_review_to_fb/:item_id' => 'product_invitations#post_review_to_fb', :as => 'post_review_to_fb'

  # Rouutess for item sharing use cases
  get 'shared/item/:id' => 'shared_items#show', :as => "shared_item"




  get 'people/all'       => 'people#index'
  get 'people/following' => 'people#following'


  # Cloudmailin incomming email controller
  post '/incoming_mails' => 'incoming_mails#create'

  # Blitz.io verification route
  get '/mu-1234-cafe-5678-babe' => proc { |env| [200, {}, '42'] }


  ##############################    NONPUBLIC ADMIN    #############################
  # These routees are not public, and should be wrapped in some type of admin
  # block

  get '/worker' => 'workers#test'

  match '/events', :to => EventMonitor
  match '/subscriptions', :to => EventMonitor

  # Live Feed
  get "feeds/show"
  get '/feed' => 'feeds#show', :as => 'feed'

  #  To use to monitor backgorund tasks
  mount Resque::Server, at: '/resque'
  get '/documentation' => redirect("http://substance.io/#sid137/prizzm")

  ########################################################################################

end
