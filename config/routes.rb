Rails.application.routes.draw do

  resources :gossips
  resources :cities, only: [:show, :index]
  resources :users

  #mise en place du root principal
  root to:'gossips#index' 

  #mise en place d'une page team depuis le controller pages
  get '/team', to: 'gossips#team', as: 'team' #création d'un nom pour le chemin

  #mise en place d'une page contact depuis le controller pages
  get '/contact', to: 'gossips#contact', as: 'contact' #création d'un nom pour le chemin

  #mise en place d'une route dynamique
  get 'welcome(/:first_name)', to: 'gossips#welcome', as: 'welcome' #création d'un nom pour le chemin
  #mise en place d'un parametre optionnel pour first_name

end