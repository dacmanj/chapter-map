ChapterMap::Application.routes.draw do
  resources :sessions
  resources :chapters

  resources :chapters do
    collection do post :import end
  end

  resources :chapters do
    collection do post :delete_multiple end
  end

  resources :users do
    collection do post :delete_multiple end
  end
  resources :users do
    member do
      get :confirm
    end
  end
  match 'embed' => 'home#embed'
  match 'pflag' => 'home#pflag'
  match 'import' => 'chapters#import'

  match "/activate" => "users#confirm"

  root :to => "home#index"
  resources :users
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/login' => 'sessions#new', :as => :signin
  match '/logout' => 'sessions#destroy', :as => :signout

  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"

end
