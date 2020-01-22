Rails.application.routes.draw do

  get 'homes/about'
  root :to => 'users#top'
  get "home/about" => "homes#about"
  devise_for :users
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
