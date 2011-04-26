CharlesItems3::Application.routes.draw do

  match "/home" => "home#index", :as  => "home"
  root :to => 'home#index'

  resource :profile

  devise_for :users, :path => "accounts", :controllers => {:registrations => "registrations"}
  resources :users do

    resources :items 
    resources :interactions
  end

  post 'items/sort', :as => :sort_items
  post 'items/rate', :as => :update_rating

  get '/fake' => "home#make_data", :as  => :fake
end
