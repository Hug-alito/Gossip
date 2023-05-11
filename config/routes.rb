Rails.application.routes.draw do

  resources :gossips
  resources :cities, only: [:show, :index]
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :gossips do
    resources :comments
  end

  resources :gossips do
    member do
      post 'like'
      delete 'dislike'
    end
  end

  root to:'gossips#index' 

  get '/team', to: 'pages#team', as: 'team'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/welcome(/:id)', to: 'pages#welcome', as: 'welcome'  

end