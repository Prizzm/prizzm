CharlesItems3::Application.routes.draw do

  match "/auth/:provider/callback" => "authentications#create"
  resources :authentications

  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile
  devise_for :users, :path => "accounts", :controllers => {:registrations => "registrations"}

  resources :users do
    resources :items 
    resources :interactions
  end

  match '/items/:item_id/images/:id/index/:index' => 'images#destroy'

  resources :interactions
  resources :items do
    resources :images, :only => [:create, :destroy]
  end

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_item_rating
  post 'interactions/rate', :as => :update_interaction_rating

  get '/fake' => "home#make_data", :as  => :fake
end
