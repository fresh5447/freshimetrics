Freshimetrics::Application.routes.draw do
  

  devise_for :users
 

  resources :users
  resources :events


  get "welcome/home"
  get "welcome/about"
  root to: 'welcome#home'
  match 'events' => "events#index", via: :options

end
