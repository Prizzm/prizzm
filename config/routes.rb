Prizzm::Application.routes.draw do
  resources :product_invitations

  # Routes to enable product autocomplete
  resources :products do
    get 'search', :on => :collection
  end

  resources :companies



  # Wanted items
  get '/wanted/:id' => 'wanted_items#owners_view', :as => 'owners_wanted_item_view'
  post '/wanted/:product_id' => 'wanted_items#create', :as => 'add_wanted_item'

  # Owned Items
  get '/owned/:id' => 'owned_items#owners_view', :as => 'owners_owned_item_view'
  post '/owned/:product_id' => 'owned_items#create', :as => 'add_owned_item'


  get  '/recommend/:item_id' => 'social#create_recommendation', :as => 'create_recommendation'
  post '/recommend/:item_id' => 'social#publish_recommendation', :as => 'publish_recommendation'


  # Routes for main page
  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile
  devise_for :users, :path => "accounts", 
            :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks", :sessions => "sessions" },
            :path_names  => {:sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'

 
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
  get  '/invitation/:id'    => 'product_invitations#view_invitation', :as  => 'view_item_invitation'
  post '/invitation'        => 'product_invitations#accept_invitation', :as => 'accept_item_invitation'
  # FIXME:  Should be using a 'GET' for routes that have side effects, but we
  # can't redirect using a 'POST' method.  Used in omniauth_callback/product_invitations
  get '/process_invitation' => 'product_invitations#process_accepted_product_invitation', :as => 'process_accepted_product_invitation'
  put '/update_item_privacy/:id' => 'items#update_privacy', :as => 'update_item_privacy'

  # Rouutess for item sharing use cases
  get 'shared/item/:id' => 'shared_items#show', :as => "shared_item"

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_item_rating
  post 'interactions/rate', :as => :update_interaction_rating

  get '/fake' => "home#make_data", :as  => :fake
end
