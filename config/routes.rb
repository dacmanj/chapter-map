ChapterMap::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  devise_scope :user do
    delete "/logout" => "devise/sessions#destroy"
  end
  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match '/users/auth/:provider/callback' => 'users#omniauth_callbacks'

                   
  resources :chapter_leaders


  resources :leaders


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
  resources :users

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

  root :to => "home#pflag"

end
