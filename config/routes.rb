ChapterMap::Application.routes.draw do
  resources :chapters

  resources :chapters do
    collection do post :import end
  end

  resources :chapters do
    collection do post :delete_multiple end
  end

  match 'embed' => 'home#embed'

  root :to => "home#index"
  resources :users
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'

end
