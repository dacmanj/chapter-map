ChapterMap::Application.routes.draw do
  resources :chapter_leaders


  resources :leaders


  resources :sessions
  resources :chapters
  resources :attachments

  resources :chapters do
    collection do post :import end
  end

  resources :chapters do
    collection do post :delete_multiple end
  end

  resources :leaders do
    collection do post :import end
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
  match 'show_chapters' => 'home#show_chapters'
  match 'import' => 'chapters#import'
  match 'leaders/import' => 'leaders#import'

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
