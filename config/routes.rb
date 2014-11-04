ChapterMap::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  devise_scope :user do
    delete "/logout" => "devise/sessions#destroy"
  end
  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match '/users/auth/:provider/callback', to: 'users#omniauth_callbacks', via: [:get, :post]

                   
  resources :chapter_leaders


  resources :members do
    collection do post :import end
  end

  resources :chapters
  resources :attachments

  resources :chapters do
    collection do post :import end
  end

  resources :chapters do
    collection do post :delete_multiple end
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


  get 'full' => 'home#full'
  get 'embed' => 'home#embed'
  get 'pflag' => 'home#pflag'
  get 'show_chapters' => 'home#show_chapters'
  get 'chapters/import' => 'chapters#import'
  get 'members/import' => 'members#import'

  get "/activate" => "users#confirm"

  root :to => "home#pflag"

end
