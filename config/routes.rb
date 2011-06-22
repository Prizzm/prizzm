Prizzm::Application.routes.draw do
  resources :product_invitations

  resources :products

  resources :companies

  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile
  devise_for :users, :path => "", 
            :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks", :sessions => "sessions" },
            :path_names  => {:sign_in => "login", :sign_out => "logout", :sign_up => "register" }
 
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
