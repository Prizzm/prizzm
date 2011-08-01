Prizzm::Application.routes.draw do

  get "feeds/show"

  # Routes for main page
  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  match "/profile/:id" => "profile#show", :as => "profile"

  # Routes to enable product autocomplete
  resources :products do
    get 'search', :on => :collection
  end


  # compositions
  get '/composer/new' => 'composer#new', :as => 'new_composition'
  post '/composer/link' => 'composer#link', :as => 'link_composer'

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

  get  '/recommend/:item_id' => 'social#create_recommendation', :as => 'create_recommendation'
  post '/recommend/:item_id' => 'social#publish_recommendation', :as => 'publish_recommendation'


  # Following things
  post '/follow/:object/:id' => 'follows#follow', :as => 'follow'
  delete '/unfollow/:object/:id' => 'follows#unfollow', :as => 'unfollow'
  post '/block/:id' => 'follows#block', :as => 'block'
  delete '/unblock/:id' => 'follows#unblock', :as => 'unblock'

  # User Login and account registration
  resource :profile
  devise_for :users, :path => "accounts", 
            :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks", :sessions => "sessions" },
            :path_names  => {:sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'

  ######################
  resources :companies do
    resources :addresses
  end 
 
  resources :users do
    resources :items do
      match 'share' => 'items#share'
    end
  end

  match '/items/:item_id/images/:id/index/:index' => 'images#destroy'

  resources :interactions
  resources :items do
    resources :interactions
    resources :images, :only => [:create, :destroy]
  end

  # Routes for item invitation use cases
  resources :product_invitations
  get  '/invitation/:id'    => 'product_invitations#view_invitation', :as  => 'view_item_invitation'
  post '/invitation'        => 'product_invitations#accept_invitation', :as => 'accept_item_invitation'
  # FIXME:  Should be using a 'GET' for routes that have side effects, but we
  # can't redirect using a 'POST' method.  Used in omniauth_callback/product_invitations
  get '/process_invitation' => 'product_invitations#process_accepted_product_invitation', :as => 'process_accepted_product_invitation'
  put '/update_item_privacy/:id' => 'items#update_privacy', :as => 'update_item_privacy'
  put '/update_item_review/:id' => 'items#update_review', :as => 'update_item_review'
  put '/update_item_name' => 'items#update_item_name', :as => 'update_item_name'

  # Rouutess for item sharing use cases
  get 'shared/item/:id' => 'shared_items#show', :as => "shared_item"

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_item_rating
  post 'interactions/rate', :as => :update_interaction_rating

  get '/mu-1234-cafe-5678-babe' => proc { |env| [200, {}, '42'] }

  match '/events', :to => EventMonitor
  match '/subscriptions', :to => EventMonitor

  # Cloudmailin incomming email controller
  post '/incoming_mails' => 'incoming_mails#create'
  get '/worker' => 'workers#test'

  # Live Feed
  get '/feed' => 'feeds#show', :as => 'feed'

  #  To use to monitor backgorund tasks
  mount Resque::Server, at: '/resque'
  get '/documentation' => redirect("http://substance.io/#sid137/prizzm")

  # Comments - this route makes the comments controller response to a
  # polymorphic types
  scope '/:commentable_type/:commentable_id' do
    resources :comments 
  end

end
