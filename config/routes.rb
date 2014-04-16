Freshimetrics::Application.routes.draw do
  devise_for :users
  get "welcome/about"

  root to: 'welcome#about'

end
