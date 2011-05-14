CharlesItems3::Application.routes.draw do
  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile
  devise_for :users, :path => "accounts", :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks" }

  resources :users do
    resources :items 
    resources :interactions
  end

  resources :interactions
  resources :items do
    resources :images, :only => [:create, :destroy]
  end

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_item_rating
  post 'interactions/rate', :as => :update_interaction_rating

  get '/fake' => "home#make_data", :as  => :fake
end
