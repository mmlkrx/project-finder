Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root 'projects#index'

  resources :projects, only: [:show, :edit, :create, :new]

end
