Prizzm::Application.routes.draw do
  resources :product_invitations

  resources :products

  resources :companies

  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile
  devise_for :users, :path => "accounts", :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks" }

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

  get  '/invitation/:id' => 'product_invitations#view_invitation', :as  => 'view_item_invitation'
  post '/invitation/:id' => 'product_invitations#accept_invitation', :as => 'accept_item_invitation'

  get 'shared/item/:id' => 'shared_items#show', :as => "shared_item"

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_item_rating
  post 'interactions/rate', :as => :update_interaction_rating

  get '/fake' => "home#make_data", :as  => :fake
end
